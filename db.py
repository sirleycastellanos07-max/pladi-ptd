import mysql.connector


def get_conexion():
    """
    Crea y devuelve una nueva conexión a la base de datos pladi-proyectos.
    Se usa en cada ruta que necesite consultar o modificar datos.
    """
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="pladi-proyectos"
    )