from db import get_conexion


def obtener_proyectos_sin_cuenta():
    """
    Devuelve la lista de proyectos que todavía no tienen
    ningún usuario asociado, usando LEFT JOIN contra la tabla usuarios.
    """
    conexion = get_conexion()
    cursor = conexion.cursor()
    cursor.execute("""
        SELECT proyectos.id, proyectos.titulo
        FROM proyectos
        LEFT JOIN usuarios ON proyectos.id = usuarios.id_proyecto
        WHERE usuarios.id IS NULL
        ORDER BY proyectos.titulo
    """)
    resultado = cursor.fetchall()
    conexion.close()
    return resultado