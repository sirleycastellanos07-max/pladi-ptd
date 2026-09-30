from werkzeug.security import generate_password_hash
from db import get_conexion

nombre_usuario = input("Nombre de usuario: ")
contrasena = input("Contraseña: ")
id_proyecto = input("ID del proyecto al que pertenece: ")

contrasena_cifrada = generate_password_hash(contrasena)

conexion = get_conexion()
cursor = conexion.cursor()
cursor.execute(
    "INSERT INTO usuarios (nombre_usuario, contrasena, id_proyecto) VALUES (%s, %s, %s)",
    (nombre_usuario, contrasena_cifrada, id_proyecto)
)
conexion.commit()
conexion.close()

print(f"Usuario '{nombre_usuario}' creado correctamente.")