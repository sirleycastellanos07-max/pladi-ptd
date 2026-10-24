from db import consultar, ejecutar, get_conexion



def obtener_proyectos_destacados():
    return consultar("""
        SELECT id, titulo, grado, grupo, imagen_principal
        FROM proyectos
        ORDER BY id
        LIMIT 3
    """)

def obtener_proyectos():
    return consultar("SELECT * FROM proyectos")


def obtener_integrantes(id_proyecto):
    return consultar(
        "SELECT nombre FROM integrantes WHERE id_proyecto = %s",
        (id_proyecto,)
    )

def obtener_todos_los_integrantes():
    return consultar("SELECT id_proyecto, nombre FROM integrantes ORDER BY id")

def obtener_progreso(id_proyecto):
    return consultar(
        "SELECT nombre_paso, estado FROM progreso WHERE id_proyecto = %s",
        (id_proyecto,)
    )

def obtener_todo_el_progreso():
    return consultar("SELECT id_proyecto, nombre_paso, estado FROM progreso ORDER BY id")

def obtener_proyectos_por_grado(grado):
    return consultar(
        "SELECT * FROM proyectos WHERE grado = %s",
        (grado,)
    )

def obtener_proyecto_por_id(id_proyecto):
    return consultar("SELECT * FROM proyectos WHERE id = %s",(id_proyecto,),uno=True)

def obtener_objetivos(id_proyecto):
    return consultar(
        "SELECT descripcion FROM objetivos_especificos WHERE id_proyecto = %s",
        (id_proyecto,)
    )

def obtener_documentos(id_proyecto):
    return consultar(
        "SELECT nombre, estado, archivo FROM documentos WHERE id_proyecto = %s",
        (id_proyecto,)
    )

def obtener_galeria(id_proyecto):
    return consultar(
        "SELECT evidencias FROM galeria WHERE id_proyecto = %s",
        (id_proyecto,)
    )

def obtener_proyectos_sin_cuenta():
    return consultar("""
        SELECT proyectos.id, proyectos.titulo
        FROM proyectos
        LEFT JOIN usuarios ON proyectos.id = usuarios.id_proyecto
        WHERE usuarios.id IS NULL
        ORDER BY proyectos.titulo
    """)

def obtener_documentos_para_editar(id_proyecto):
    return consultar(
        "SELECT id, nombre, estado, archivo FROM documentos WHERE id_proyecto = %s ORDER BY id",
        (id_proyecto,)
    )

def obtener_usuario_login(usuario):
    return consultar(
        "SELECT id, contrasena, id_proyecto FROM usuarios WHERE nombre_usuario = %s",
        (usuario,),
        uno=True
    )

def actualizar_proyecto(id_proyecto, titulo, descripcion, objetivo_general):
    ejecutar(
        """
        UPDATE proyectos
        SET titulo = %s, descripcion = %s, objetivo_general = %s WHERE id = %s """,
        (titulo, descripcion, objetivo_general, id_proyecto)
    )

def guardar_integrantes(id_proyecto, nombres):
    conexion = get_conexion()
    cursor = conexion.cursor()

    try:
        # Guardamos la foto y el rol de cada integrante para no perderlos
        cursor.execute(
            "SELECT nombre, foto, rol FROM integrantes WHERE id_proyecto = %s",
            (id_proyecto,)
        )
        datos_anteriores = {fila[0]: (fila[1], fila[2]) for fila in cursor.fetchall()}

        cursor.execute(
            "DELETE FROM integrantes WHERE id_proyecto = %s",
            (id_proyecto,)
        )

        for nombre in nombres:
            foto, rol = datos_anteriores.get(nombre, (None, None))
            cursor.execute(
                "INSERT INTO integrantes (id_proyecto, nombre, foto, rol) VALUES (%s, %s, %s, %s)",
                (id_proyecto, nombre, foto, rol)
            )

        conexion.commit()

    except Exception:
        conexion.rollback()
        raise

    finally:
        cursor.close()
        conexion.close()

def guardar_objetivos(id_proyecto, objetivos):
    conexion = get_conexion()
    cursor = conexion.cursor()

    try:
        cursor.execute(
            "DELETE FROM objetivos_especificos WHERE id_proyecto = %s",
            (id_proyecto,)
        )

        for objetivo in objetivos:
            cursor.execute(
                "INSERT INTO objetivos_especificos (id_proyecto, descripcion) VALUES (%s, %s)",
                (id_proyecto, objetivo)
            )

        conexion.commit()

    except Exception:
        conexion.rollback()
        raise

    finally:
        cursor.close()
        conexion.close()

def guardar_foto_galeria(id_proyecto, ruta_relativa):
    ejecutar(
        "INSERT INTO galeria (id_proyecto, evidencias) VALUES (%s, %s)",
        (id_proyecto, ruta_relativa)
    )

def actualizar_imagen_principal(id_proyecto, ruta_relativa):
    ejecutar(
        "UPDATE proyectos SET imagen_principal = %s WHERE id = %s",
        (ruta_relativa, id_proyecto)
    )

def actualizar_cronograma(id_proyecto, ruta_relativa):
    ejecutar(
        "UPDATE proyectos SET imagen_cronograma = %s WHERE id = %s",
        (ruta_relativa, id_proyecto)
    )

def asegurar_tabla_eventos():
    """
    Si la tabla 'eventos' no existe, la crea y le pone los eventos
    generales que ya tenía el calendario. Si ya existe, no hace nada.
    Así nadie tiene que crearla a mano en phpMyAdmin.
    """
    conexion = get_conexion()
    cursor = conexion.cursor()

    try:
        cursor.execute("SHOW TABLES LIKE 'eventos'")
        if cursor.fetchone():
            return

        cursor.execute("""
            CREATE TABLE IF NOT EXISTS `eventos` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `id_proyecto` int(11) DEFAULT NULL,
              `fecha` date NOT NULL,
              `titulo` varchar(150) NOT NULL,
              `descripcion` text DEFAULT NULL,
              `tipo` varchar(20) NOT NULL DEFAULT 'verde',
              PRIMARY KEY (`id`),
              KEY `id_proyecto` (`id_proyecto`),
              CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id`) ON DELETE CASCADE
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
        """)

        # Eventos generales que ya estaban en el calendario (no son de ningún grupo)
        cursor.executemany(
            "INSERT INTO eventos (id_proyecto, fecha, titulo, descripcion, tipo) VALUES (NULL, %s, %s, NULL, %s)",
            [
                ('2026-08-07', 'Seguimiento de proyecto', 'verde'),
                ('2026-08-15', 'Entrega', 'amarillo'),
                ('2026-08-20', 'Reunión', 'negro'),
                ('2026-08-25', 'Actividad académica', 'gris'),
            ]
        )
        conexion.commit()

    finally:
        cursor.close()
        conexion.close()

def obtener_eventos():
    return consultar("""
        SELECT eventos.id, eventos.fecha, eventos.titulo, eventos.descripcion,
               eventos.tipo, eventos.id_proyecto, proyectos.grupo
        FROM eventos
        LEFT JOIN proyectos ON proyectos.id = eventos.id_proyecto
        ORDER BY eventos.fecha, eventos.id
    """)

def obtener_eventos_de_proyecto(id_proyecto):
    return consultar(
        "SELECT id, fecha, titulo, descripcion, tipo FROM eventos WHERE id_proyecto = %s ORDER BY fecha, id",
        (id_proyecto,)
    )

def obtener_evento(id_evento):
    return consultar(
        "SELECT id, fecha, titulo, descripcion, tipo, id_proyecto FROM eventos WHERE id = %s",
        (id_evento,),
        uno=True
    )

def crear_evento(id_proyecto, fecha, titulo, descripcion, tipo):
    ejecutar(
        "INSERT INTO eventos (id_proyecto, fecha, titulo, descripcion, tipo) VALUES (%s, %s, %s, %s, %s)",
        (id_proyecto, fecha, titulo, descripcion, tipo)
    )

# En actualizar y eliminar también pedimos el id_proyecto,
# así un grupo nunca puede tocar los eventos de otro grupo
def actualizar_evento(id_evento, id_proyecto, fecha, titulo, descripcion, tipo):
    ejecutar(
        """
        UPDATE eventos
        SET fecha = %s, titulo = %s, descripcion = %s, tipo = %s
        WHERE id = %s AND id_proyecto = %s """,
        (fecha, titulo, descripcion, tipo, id_evento, id_proyecto)
    )

def eliminar_evento(id_evento, id_proyecto):
    ejecutar(
        "DELETE FROM eventos WHERE id = %s AND id_proyecto = %s",
        (id_evento, id_proyecto)
    )

def actualizar_documento(doc_id, nuevo_estado, ruta_relativa=None):
    if ruta_relativa:
        ejecutar(
            "UPDATE documentos SET estado = %s, archivo = %s WHERE id = %s",
            (nuevo_estado, ruta_relativa, doc_id)
        )
    else:
        ejecutar(
            "UPDATE documentos SET estado = %s WHERE id = %s",
            (nuevo_estado, doc_id)
        )




