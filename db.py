import mysql.connector


def get_conexion():
    return mysql.connector.connect(
        host="localhost",
        port=3306,
        user="root",
        password="GestionAdministrativa26*",
        database="pladi-proyectos"
    )

def consultar(sql, parametros=(), uno=False):
    conexion = get_conexion()
    cursor = conexion.cursor()

    try:
        cursor.execute(sql, parametros)

        if uno:
            return cursor.fetchone()

        return cursor.fetchall()

    finally:
        cursor.close()
        conexion.close()


def ejecutar(sql, parametros=()):
    conexion = get_conexion()
    cursor = conexion.cursor()

    try:
        cursor.execute(sql, parametros)
        conexion.commit()
        return cursor.lastrowid

    except Exception:
        conexion.rollback()
        raise

    finally:
        cursor.close()
        conexion.close()
