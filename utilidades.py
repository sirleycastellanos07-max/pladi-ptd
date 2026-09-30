def nombre_corto(nombre_completo):
    """
    Convierte 'ALCANTAR CAICEDO ROGER STEPHAN' en 'Alcántar R.'
    Toma la primera palabra como apellido, y la inicial de la última palabra como nombre.
    """
    partes = nombre_completo.strip().split()
    if len(partes) == 0:
        return ""
    apellido = partes[0].capitalize()
    inicial = partes[-1][0].upper() if len(partes) > 1 else ""
    if inicial:
        return f"{apellido} {inicial}."
    return apellido


def inicial_avatar(nombre_completo):
    """
    Devuelve solo la primera letra del nombre, en mayúscula, para el avatar.
    """
    partes = nombre_completo.strip().split()
    if len(partes) == 0:
        return "?"
    return partes[0][0].upper()

def calcular_progreso(pasos):
    """
    Recibe la lista de pasos (nombre_paso, estado) de un proyecto
    y devuelve (porcentaje, estado_general).
    """
    total_pasos = len(pasos)
    completados = 0
    for paso in pasos:
        if paso[1] == "Completado":
            completados += 1

    if total_pasos > 0:
        porcentaje = (completados / total_pasos) * 100
    else:
        porcentaje = 0

    if porcentaje == 0:
        estado = "Sin iniciar"
    elif porcentaje > 0 and porcentaje < 100:
        estado = "En desarrollo"
    else:
        estado = "Finalizado"

    return porcentaje, estado