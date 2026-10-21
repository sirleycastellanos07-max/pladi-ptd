from flask import Flask, render_template, request
from db import get_conexion
from utilidades import nombre_corto, inicial_avatar, calcular_progreso
from flask import Flask, render_template, request, redirect, session
from werkzeug.security import check_password_hash, generate_password_hash
from consultas import (
    obtener_proyectos_sin_cuenta,
    obtener_proyectos_destacados,
    obtener_proyectos,
    obtener_proyectos_por_grado,
    obtener_integrantes,
    obtener_progreso,
    obtener_proyecto_por_id,
    obtener_objetivos,
    obtener_documentos,
    obtener_galeria,
    obtener_proyecto_para_editar,
    obtener_objetivos_para_editar,
    obtener_galeria_para_editar,
    obtener_documentos_para_editar,
    obtener_integrantes_para_editar,
    obtener_usuario_login,
    actualizar_proyecto,
    guardar_integrantes,
    guardar_objetivos,
    actualizar_proyecto,
    guardar_foto_galeria,
    actualizar_documento,

)
from werkzeug.utils import secure_filename
import os
from flask import session, redirect, url_for    

app = Flask(__name__)
app.secret_key = "cambia_esto_por_un_texto_secreto_largo_y_unico"


@app.route('/index')
def index():
    destacados = obtener_proyectos_destacados()
    return render_template('index.html', destacados=destacados) 

@app.route('/calendario')
def calendario():
    return render_template('calendario.html')

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

    lista_completa = []

    for p in proyectos_db:
        integrantes_raw = obtener_integrantes(p[0])
        integrantes = [(nombre_corto(i[0]), inicial_avatar(i[0])) for i in integrantes_raw]

        pasos = obtener_progreso(p[0])
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
        fotos_nuevas = request.files.getlist('galeria_nuevas')

        for foto in fotos_nuevas:
            if foto and foto.filename != '':
                nombre_archivo = secure_filename(foto.filename)
                ruta_relativa = 'imagenes/' + nombre_archivo
                foto.save(os.path.join('static', ruta_relativa))

                guardar_foto_galeria(id_proyecto, ruta_relativa)

        # Documentos
        ids_documentos = request.form.getlist('documento_id[]')
        estados_documentos = request.form.getlist('documento_estado[]')
        archivos_documentos = request.files.getlist('documento_archivo[]')

        for i in range(len(ids_documentos)):
            doc_id = ids_documentos[i]
            nuevo_estado = estados_documentos[i]

            if i < len(archivos_documentos):
                archivo_doc = archivos_documentos[i]
            else:
                archivo_doc = None

            ruta_relativa = None

            if archivo_doc and archivo_doc.filename != '':
                nombre_archivo = secure_filename(archivo_doc.filename)
                ruta_relativa = 'documentos/' + nombre_archivo
                archivo_doc.save(os.path.join('static', ruta_relativa))

            actualizar_documento(
                doc_id, nuevo_estado, ruta_relativa
            )

        return redirect('/proyecto/' + str(id_proyecto))

    proyecto = obtener_proyecto_para_editar(id_proyecto)
    integrantes = obtener_integrantes_para_editar(id_proyecto)
    objetivos = obtener_objetivos_para_editar(id_proyecto)
    galeria = obtener_galeria_para_editar(id_proyecto)
    documentos = obtener_documentos_para_editar(id_proyecto)

    return render_template('editar.html',proyecto=proyecto, integrantes=integrantes, objetivos=objetivos, galeria=galeria, documentos=documentos)

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        titulo = request.form.get('titulo')
        grado = request.form.get('grado')
        grupo = request.form.get('grupo')
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

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
    conexion = get_conexion()
    cursor = conexion.cursor()

    if request.method == 'POST':
        id_proyecto = request.form.get('id_proyecto')
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

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

    conexion.close()
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