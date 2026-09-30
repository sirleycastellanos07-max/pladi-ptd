from flask import Flask, render_template, request
from db import get_conexion
from utilidades import nombre_corto, inicial_avatar, calcular_progreso
from flask import Flask, render_template, request, redirect, session
from werkzeug.security import check_password_hash, generate_password_hash

app = Flask(__name__)
app.secret_key = "cambia_esto_por_un_texto_secreto_largo_y_unico"


@app.route('/')
def inicio():
    conexion = get_conexion()
    cursor = conexion.cursor()
    cursor.execute("SELECT id, titulo, grado, grupo FROM proyectos LIMIT 3")
    destacados = cursor.fetchall()
    conexion.close()
    return render_template('inicio.html', destacados=destacados)


@app.route('/proyectos')
def proyectos():
    conexion = get_conexion()
    cursor = conexion.cursor()
    grado_filtro = request.args.get('grado')

    if grado_filtro:
        cursor.execute("SELECT * FROM proyectos WHERE grado = %s", (grado_filtro,))
    else:
        cursor.execute("SELECT * FROM proyectos")
    proyectos_db = cursor.fetchall()

    lista_completa = []
    for p in proyectos_db:
        cursor.execute("SELECT nombre FROM integrantes WHERE id_proyecto = %s", (p[0],))
        integrantes_raw = cursor.fetchall()
        integrantes = [(nombre_corto(i[0]), inicial_avatar(i[0])) for i in integrantes_raw]

        cursor.execute("SELECT nombre_paso, estado FROM progreso WHERE id_proyecto = %s", (p[0],))
        pasos = cursor.fetchall()

        porcentaje, estado = calcular_progreso(pasos)

        lista_completa.append((p, integrantes, porcentaje, estado))

    conexion.close()
    return render_template('proyectos.html', lista_proyectos=lista_completa)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        usuario = request.form.get('usuario')
        contrasena = request.form.get('contrasena')

        conexion = get_conexion()
        cursor = conexion.cursor()
        cursor.execute("SELECT id, contrasena, id_proyecto FROM usuarios WHERE nombre_usuario = %s", (usuario,))
        resultado = cursor.fetchone()
        conexion.close()

        if resultado and check_password_hash(resultado[1], contrasena):
            session['id_proyecto'] = resultado[2]
            session['usuario'] = usuario
            return redirect('/proyecto/' + str(resultado[2]))
        else:
            return render_template('login.html', error='Usuario o contraseña incorrectos')

    return render_template('login.html', error=None)


@app.route('/proyecto/<int:id_proyecto>/editar', methods=['GET', 'POST'])
def editar(id_proyecto):
    if 'usuario' not in session:
        return redirect('/login')

    if session['id_proyecto'] != id_proyecto:
        return "No tienes permiso para editar este proyecto", 403

    conexion = get_conexion()
    cursor = conexion.cursor()

    if request.method == 'POST':
        titulo = request.form.get('titulo')
        descripcion = request.form.get('descripcion')
        objetivo_general = request.form.get('objetivo_general')

        cursor.execute(
            "UPDATE proyectos SET titulo = %s, descripcion = %s, objetivo_general = %s WHERE id = %s",
            (titulo, descripcion, objetivo_general, id_proyecto)
        )

        nombres_integrantes = request.form.getlist('integrantes[]')
        nombres_integrantes = [n.strip() for n in nombres_integrantes if n.strip()]

        cursor.execute("DELETE FROM integrantes WHERE id_proyecto = %s", (id_proyecto,))
        for nombre in nombres_integrantes:
            cursor.execute("INSERT INTO integrantes (id_proyecto, nombre) VALUES (%s, %s)", (id_proyecto, nombre))

        objetivos_especificos = request.form.getlist('objetivos[]')
        objetivos_especificos = [o.strip() for o in objetivos_especificos if o.strip()]

        cursor.execute("DELETE FROM objetivos_especificos WHERE id_proyecto = %s", (id_proyecto,))
        for objetivo in objetivos_especificos:
            cursor.execute("INSERT INTO objetivos_especificos (id_proyecto, descripcion) VALUES (%s, %s)", (id_proyecto, objetivo))

        conexion.commit()
        conexion.close()
        return redirect('/proyecto/' + str(id_proyecto))

    cursor.execute("SELECT * FROM proyectos WHERE id = %s", (id_proyecto,))
    proyecto = cursor.fetchone()

    cursor.execute("SELECT nombre FROM integrantes WHERE id_proyecto = %s", (id_proyecto,))
    integrantes = cursor.fetchall()

    cursor.execute("SELECT descripcion FROM objetivos_especificos WHERE id_proyecto = %s", (id_proyecto,))
    objetivos = cursor.fetchall()

    conexion.close()

    return render_template('editar.html', proyecto=proyecto, integrantes=integrantes, objetivos=objetivos)

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

@app.route('/proyecto/<int:id_proyecto>')
def detalle(id_proyecto):
    conexion = get_conexion()
    cursor = conexion.cursor()

    cursor.execute("SELECT * FROM proyectos WHERE id = %s", (id_proyecto,))
    proyecto = cursor.fetchone()

    cursor.execute("SELECT nombre FROM integrantes WHERE id_proyecto = %s", (id_proyecto,))
    integrantes_raw = cursor.fetchall()
    integrantes = [(nombre_corto(i[0]), inicial_avatar(i[0])) for i in integrantes_raw]

    cursor.execute("SELECT descripcion FROM objetivos_especificos WHERE id_proyecto = %s", (id_proyecto,))
    objetivos = cursor.fetchall()

    cursor.execute("SELECT nombre, estado FROM documentos WHERE id_proyecto = %s", (id_proyecto,))
    documentos = cursor.fetchall()

    cursor.execute("SELECT evidencias FROM galeria WHERE id_proyecto = %s", (id_proyecto,))
    galeria = cursor.fetchall()

    cursor.execute("SELECT nombre_paso, estado FROM progreso WHERE id_proyecto = %s", (id_proyecto,))
    progreso = cursor.fetchall()
    porcentaje, estado = calcular_progreso(progreso)

    conexion.close()

    return render_template('detalle.html', proyecto=proyecto, integrantes=integrantes,
                            objetivos=objetivos, documentos=documentos, galeria=galeria, progreso=progreso, porcentaje=porcentaje, estado=estado)


if __name__ == '__main__':
    app.run(debug=True)