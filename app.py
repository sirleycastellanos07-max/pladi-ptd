import os
import hmac
import uuid
from datetime import date
from flask import Flask, render_template, request, redirect, session, url_for
from werkzeug.security import check_password_hash, generate_password_hash
from werkzeug.utils import secure_filename
from db import get_conexion
from utilidades import nombre_corto, inicial_avatar, calcular_progreso
from consultas import (
    obtener_proyectos_sin_cuenta,
    obtener_proyectos_destacados,
    obtener_proyectos,
    obtener_proyectos_por_grado,
    obtener_integrantes,
    obtener_todos_los_integrantes,
    obtener_progreso,
    obtener_todo_el_progreso,
    obtener_proyecto_por_id,
    obtener_objetivos,
    obtener_documentos,
    obtener_galeria,
    obtener_documentos_para_editar,
    obtener_usuario_login,
    actualizar_proyecto,
    guardar_integrantes,
    guardar_objetivos,
    guardar_foto_galeria,
    actualizar_documento,
    actualizar_cronograma,
    actualizar_imagen_principal,
    obtener_eventos,
    obtener_eventos_de_proyecto,
    obtener_evento,
    crear_evento,
    actualizar_evento,
    eliminar_evento,
)

app = Flask(__name__)
app.secret_key = "cambia_esto_por_un_texto_secreto_largo_y_unico"

# Código que la docente entrega a los grupos para poder registrarse
CODIGO_REGISTRO = "LICEO-28449C"

# Tamaño máximo de lo que se puede subir de una vez (16 MB)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024

EXTENSIONES_IMAGEN = {'png', 'jpg', 'jpeg', 'gif', 'webp'}
EXTENSIONES_DOCUMENTO = {'pdf', 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx', 'txt'}


def extension_valida(archivo, permitidas):
    nombre = archivo.filename
    return '.' in nombre and nombre.rsplit('.', 1)[1].lower() in permitidas


def guardar_archivo(archivo, carpeta, id_proyecto):
    """
    Guarda el archivo con un nombre único (para no reemplazar el de otro grupo)
    y devuelve la ruta relativa, por ejemplo 'imagenes/p5-1a2b3c4d-foto.png'.
    """
    extension = archivo.filename.rsplit('.', 1)[1].lower()
    nombre_seguro = secure_filename(archivo.filename)
    if not nombre_seguro.lower().endswith('.' + extension):
        nombre_seguro = 'archivo.' + extension

    nombre_final = f"p{id_proyecto}-{uuid.uuid4().hex[:8]}-{nombre_seguro}"

    carpeta_destino = os.path.join(app.static_folder, carpeta)
    os.makedirs(carpeta_destino, exist_ok=True)
    archivo.save(os.path.join(carpeta_destino, nombre_final))

    return carpeta + '/' + nombre_final


def imagen_proyecto(id_proyecto, imagen_principal=None):
    """
    Devuelve la imagen que se debe mostrar para un proyecto:
    primero la que el grupo subió, si no la de siempre (imagenes/<id>.jpeg).
    Si no hay ninguna, devuelve None.
    """
    opciones = [imagen_principal, 'imagenes/' + str(id_proyecto) + '.jpeg']
    for ruta in opciones:
        if ruta and os.path.exists(os.path.join(app.static_folder, ruta)):
            return ruta
    return None


# Así se puede usar imagen_proyecto(...) dentro de las plantillas HTML
app.jinja_env.globals['imagen_proyecto'] = imagen_proyecto


def codigo_registro_valido(codigo):
    return hmac.compare_digest((codigo or '').strip(), CODIGO_REGISTRO)


@app.errorhandler(413)
def archivo_muy_grande(error):
    return "Los archivos son muy pesados. El máximo es 16 MB en total.", 413


@app.route('/')
@app.route('/index')
def index():
    destacados = obtener_proyectos_destacados()
    return render_template('index.html', destacados=destacados) 

# Colores de los eventos y lo que significa cada uno (igual que la leyenda del calendario)
TIPOS_EVENTO = {
    'verde': 'Actividad académica',
    'amarillo': 'Entrega',
    'negro': 'Reunión',
    'gris': 'Evento institucional',
}


@app.route('/calendario')
def calendario():
    eventos = []
    for e in obtener_eventos():
        eventos.append({
            'fecha': e[1].isoformat(),
            'titulo': e[2],
            'descripcion': e[3] or '',
            'tipo': e[4] if e[4] in TIPOS_EVENTO else 'verde',
            'grupo': e[6] or '',
        })

    return render_template('calendario.html', eventos=eventos)


def leer_formulario_evento():
    """
    Lee los datos del formulario de un evento y los revisa.
    Devuelve (datos, error). Si todo está bien, error es None.
    """
    datos = {
        'fecha': (request.form.get('fecha') or '').strip(),
        'titulo': (request.form.get('titulo') or '').strip(),
        'descripcion': (request.form.get('descripcion') or '').strip(),
        'tipo': request.form.get('tipo') or 'verde',
    }

    try:
        date.fromisoformat(datos['fecha'])
    except ValueError:
        return datos, 'Escribe una fecha válida.'

    if not datos['titulo']:
        return datos, 'El evento necesita un título.'

    if len(datos['titulo']) > 150:
        return datos, 'El título es muy largo (máximo 150 letras).'

    if datos['tipo'] not in TIPOS_EVENTO:
        return datos, 'Elige un tipo de evento de la lista.'

    return datos, None


@app.route('/calendario/mis-eventos', methods=['GET', 'POST'])
def mis_eventos():
    if 'usuario' not in session:
        return redirect('/login')

    id_proyecto = session['id_proyecto']
    error = None
    datos = {}

    if request.method == 'POST':
        datos, error = leer_formulario_evento()

        if not error:
            crear_evento(id_proyecto, datos['fecha'], datos['titulo'], datos['descripcion'] or None, datos['tipo'])
            return redirect(url_for('mis_eventos'))

    eventos = obtener_eventos_de_proyecto(id_proyecto)
    return render_template('mis_eventos.html', eventos=eventos, tipos=TIPOS_EVENTO, error=error, datos=datos)


@app.route('/calendario/evento/<int:id_evento>/editar', methods=['GET', 'POST'])
def editar_evento(id_evento):
    if 'usuario' not in session:
        return redirect('/login')

    evento = obtener_evento(id_evento)

    if evento is None:
        return "Evento no encontrado", 404

    if evento[5] != session['id_proyecto']:
        return "No tienes permiso para editar este evento", 403

    error = None
    datos = {
        'fecha': evento[1].isoformat(),
        'titulo': evento[2],
        'descripcion': evento[3] or '',
        'tipo': evento[4],
    }

    if request.method == 'POST':
        datos, error = leer_formulario_evento()

        if not error:
            actualizar_evento(id_evento, session['id_proyecto'], datos['fecha'], datos['titulo'], datos['descripcion'] or None, datos['tipo'])
            return redirect(url_for('mis_eventos'))

    return render_template('editar_evento.html', id_evento=id_evento, tipos=TIPOS_EVENTO, error=error, datos=datos)


@app.route('/calendario/evento/<int:id_evento>/eliminar', methods=['POST'])
def borrar_evento(id_evento):
    if 'usuario' not in session:
        return redirect('/login')

    evento = obtener_evento(id_evento)

    if evento is None:
        return "Evento no encontrado", 404

    if evento[5] != session['id_proyecto']:
        return "No tienes permiso para eliminar este evento", 403

    eliminar_evento(id_evento, session['id_proyecto'])
    return redirect(url_for('mis_eventos'))

@app.route('/nosotros')
def nosotros():
    return render_template('nosotros.html')


@app.route('/proyectos')
def proyectos():
    grado_filtro = request.args.get('grado')

    if grado_filtro:
        proyectos_db = obtener_proyectos_por_grado(grado_filtro)
    else:
        proyectos_db = obtener_proyectos()

    # Traemos todos los integrantes y el progreso de una sola vez
    # y luego los repartimos por proyecto (así la página carga más rápido)
    integrantes_por_proyecto = {}
    for id_proyecto, nombre in obtener_todos_los_integrantes():
        integrantes_por_proyecto.setdefault(id_proyecto, []).append(nombre)

    progreso_por_proyecto = {}
    for id_proyecto, nombre_paso, estado_paso in obtener_todo_el_progreso():
        progreso_por_proyecto.setdefault(id_proyecto, []).append((nombre_paso, estado_paso))

    lista_completa = []

    for p in proyectos_db:
        nombres = integrantes_por_proyecto.get(p[0], [])
        integrantes = [(nombre_corto(n), inicial_avatar(n)) for n in nombres]

        pasos = progreso_por_proyecto.get(p[0], [])
        porcentaje, estado = calcular_progreso(pasos)

        lista_completa.append((p, integrantes, porcentaje, estado))

    return render_template('proyectos.html',lista_proyectos=lista_completa,grado_filtro=grado_filtro)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

        resultado = obtener_usuario_login(usuario)

        if resultado and check_password_hash(resultado[1], contrasena):
            session['id_proyecto'] = resultado[2]
            session['usuario'] = usuario
            return redirect('/proyecto/' + str(resultado[2]))
        else:
            return render_template('login.html', error='Usuario o contraseña incorrectos')

    return render_template('login.html', error=None)

@app.route('/cerrar-sesion')
def cerrar_sesion():
    session.clear()
    return redirect(url_for('index'))


@app.route('/proyecto/<int:id_proyecto>/editar', methods=['GET', 'POST'])
def editar(id_proyecto):
    if 'usuario' not in session:
        return redirect('/login')

    if session['id_proyecto'] != id_proyecto:
        return "No tienes permiso para editar este proyecto", 403

    if request.method == 'POST':
        # Revisamos primero que todos los archivos sean del tipo correcto
        fotos_nuevas = [f for f in request.files.getlist('galeria_nuevas') if f and f.filename != '']
        imagen_principal = request.files.get('imagen_principal')
        cronograma = request.files.get('cronograma')
        archivos_documentos = request.files.getlist('documento_archivo[]')

        for foto in fotos_nuevas:
            if not extension_valida(foto, EXTENSIONES_IMAGEN):
                return mostrar_editar(id_proyecto, 'Las fotos deben ser imágenes (png, jpg, jpeg, gif o webp).')

        if imagen_principal and imagen_principal.filename != '' and not extension_valida(imagen_principal, EXTENSIONES_IMAGEN):
            return mostrar_editar(id_proyecto, 'La imagen principal debe ser una imagen (png, jpg, jpeg, gif o webp).')

        if cronograma and cronograma.filename != '' and not extension_valida(cronograma, EXTENSIONES_IMAGEN):
            return mostrar_editar(id_proyecto, 'El cronograma debe ser una imagen (png, jpg, jpeg, gif o webp).')

        for archivo_doc in archivos_documentos:
            if archivo_doc and archivo_doc.filename != '' and not extension_valida(archivo_doc, EXTENSIONES_DOCUMENTO):
                return mostrar_editar(id_proyecto, 'Los documentos deben ser pdf, Word, PowerPoint, Excel o txt.')

        titulo = request.form.get('titulo')
        descripcion = request.form.get('descripcion')
        objetivo_general = request.form.get('objetivo_general')

        actualizar_proyecto(
            id_proyecto, titulo, descripcion, objetivo_general
        )

        nombres_integrantes = request.form.getlist('integrantes[]')
        nombres_integrantes = [
            n.strip() for n in nombres_integrantes if n.strip()
        ]
        guardar_integrantes(id_proyecto, nombres_integrantes)

        objetivos_especificos = request.form.getlist('objetivos[]')
        objetivos_especificos = [
            o.strip() for o in objetivos_especificos if o.strip()
        ]
        guardar_objetivos(id_proyecto, objetivos_especificos)

        # Galería: fotos nuevas
        for foto in fotos_nuevas:
            ruta_relativa = guardar_archivo(foto, 'imagenes', id_proyecto)
            guardar_foto_galeria(id_proyecto, ruta_relativa)

        # Imagen principal del proyecto
        if imagen_principal and imagen_principal.filename != '':
            ruta_relativa = guardar_archivo(imagen_principal, 'imagenes', id_proyecto)
            actualizar_imagen_principal(id_proyecto, ruta_relativa)

        # Cronograma
        if cronograma and cronograma.filename != '':
            ruta_relativa = guardar_archivo(cronograma, 'imagenes', id_proyecto)
            actualizar_cronograma(id_proyecto, ruta_relativa)

        # Documentos
        ids_documentos = request.form.getlist('documento_id[]')
        estados_documentos = request.form.getlist('documento_estado[]')

        for i in range(len(ids_documentos)):
            doc_id = ids_documentos[i]
            nuevo_estado = estados_documentos[i]

            if i < len(archivos_documentos):
                archivo_doc = archivos_documentos[i]
            else:
                archivo_doc = None

            ruta_relativa = None

            if archivo_doc and archivo_doc.filename != '':
                ruta_relativa = guardar_archivo(archivo_doc, 'documentos', id_proyecto)

            actualizar_documento(
                doc_id, nuevo_estado, ruta_relativa
            )

        return redirect('/proyecto/' + str(id_proyecto))

    return mostrar_editar(id_proyecto)


def mostrar_editar(id_proyecto, error=None):
    proyecto = obtener_proyecto_por_id(id_proyecto)
    integrantes = obtener_integrantes(id_proyecto)
    objetivos = obtener_objetivos(id_proyecto)
    documentos = obtener_documentos_para_editar(id_proyecto)

    return render_template('editar.html',proyecto=proyecto, integrantes=integrantes, objetivos=objetivos, documentos=documentos, error=error)

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        titulo = request.form.get('titulo')
        grado = request.form.get('grado')
        grupo = request.form.get('grupo')
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

        if not codigo_registro_valido(request.form.get('codigo')):
            return render_template('registro.html', error='El código de registro no es correcto. Pídeselo a tu docente.')

        conexion = get_conexion()
        cursor = conexion.cursor()

        cursor.execute("SELECT id FROM usuarios WHERE nombre_usuario = %s", (usuario,))
        existe = cursor.fetchone()

        if existe:
            conexion.close()
            return render_template('registro.html', error='Ese nombre de usuario ya está en uso, elige otro')

        cursor.execute(
            "INSERT INTO proyectos (titulo, grado, grupo) VALUES (%s, %s, %s)",
            (titulo, grado, grupo)
        )
        id_proyecto_nuevo = cursor.lastrowid

        contrasena_cifrada = generate_password_hash(contrasena)
        cursor.execute(
            "INSERT INTO usuarios (nombre_usuario, contrasena, id_proyecto) VALUES (%s, %s, %s)",
            (usuario, contrasena_cifrada, id_proyecto_nuevo)
        )

        conexion.commit()
        conexion.close()

        session['usuario'] = usuario
        session['id_proyecto'] = id_proyecto_nuevo

        return redirect('/proyecto/' + str(id_proyecto_nuevo) + '/editar')

    return render_template('registro.html', error=None)

@app.route('/crear-cuenta', methods=['GET', 'POST'])
def crear_cuenta():
    if request.method == 'POST':
        id_proyecto = request.form.get('id_proyecto')
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

        if not codigo_registro_valido(request.form.get('codigo')):
            return render_template('crear_cuenta.html', error='El código de registro no es correcto. Pídeselo a tu docente.', proyectos=obtener_proyectos_sin_cuenta())

        if not (id_proyecto or '').isdigit() or obtener_proyecto_por_id(int(id_proyecto)) is None:
            return render_template('crear_cuenta.html', error='Selecciona un proyecto de la lista', proyectos=obtener_proyectos_sin_cuenta())

        conexion = get_conexion()
        cursor = conexion.cursor()

        cursor.execute("SELECT id FROM usuarios WHERE nombre_usuario = %s", (usuario,))
        existe_usuario = cursor.fetchone()

        cursor.execute("SELECT id FROM usuarios WHERE id_proyecto = %s", (id_proyecto,))
        proyecto_ya_tiene_cuenta = cursor.fetchone()

        if existe_usuario:
            conexion.close()
            return render_template('crear_cuenta.html', error='Ese nombre de usuario ya está en uso, elige otro', proyectos=obtener_proyectos_sin_cuenta())

        if proyecto_ya_tiene_cuenta:
            conexion.close()
            return render_template('crear_cuenta.html', error='Ese proyecto ya tiene una cuenta creada', proyectos=obtener_proyectos_sin_cuenta())

        contrasena_cifrada = generate_password_hash(contrasena)
        cursor.execute(
            "INSERT INTO usuarios (nombre_usuario, contrasena, id_proyecto) VALUES (%s, %s, %s)",
            (usuario, contrasena_cifrada, id_proyecto)
        )
        conexion.commit()
        conexion.close()

        session['usuario'] = usuario
        session['id_proyecto'] = int(id_proyecto)

        return redirect('/proyecto/' + str(id_proyecto) + '/editar')

    return render_template('crear_cuenta.html', error=None, proyectos=obtener_proyectos_sin_cuenta())


@app.route('/proyecto/<int:id_proyecto>')
def detalle(id_proyecto):
    proyecto = obtener_proyecto_por_id(id_proyecto)

    if proyecto is None:
        return "Proyecto no encontrado", 404

    integrantes_raw = obtener_integrantes(id_proyecto)
    integrantes = [
        (nombre_corto(i[0]), inicial_avatar(i[0]))
        for i in integrantes_raw
    ]

    objetivos = obtener_objetivos(id_proyecto)
    documentos = obtener_documentos(id_proyecto)
    galeria = obtener_galeria(id_proyecto)

    progreso = obtener_progreso(id_proyecto)
    porcentaje, estado = calcular_progreso(progreso)

    return render_template('detalle.html',proyecto=proyecto, integrantes=integrantes, objetivos=objetivos, documentos=documentos, galeria=galeria, progreso=progreso, porcentaje=porcentaje, estado=estado)

if __name__ == '__main__':
    app.run(debug=True)