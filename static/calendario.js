// new Date() obtiene automáticamente la fecha actual del computador.
let fechaActual = new Date();

let mesActual = fechaActual.getMonth();

let añoActual = fechaActual.getFullYear();


/* ELEMENTOS DEL HTML */

// Buscamos en el HTML el elemento donde vamos a mostrar
// el nombre del mes y el año.
const tituloMes = document.getElementById("mesActual");

// Buscamos el espacio donde aparecerán todos los días.
const diasCalendario = document.getElementById("diasCalendario");

// Buscamos el botón para ir al mes anterior.
const botonAnterior = document.getElementById("mesAnterior");

// Buscamos el botón para ir al mes siguiente.
const botonSiguiente = document.getElementById("mesSiguiente");


/* NOMBRES DE LOS MESES */

const nombresMeses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
];


/* EVENTOS ACADÉMICOS */

// Aquí guardamos las actividades que queremos mostrar
const eventos = {

    "2026-8-7": {
        texto: "Seguimiento de proyecto",
        tipo: "verde"
    },

    "2026-8-15": {
        texto: "Entrega",
        tipo: "amarillo"
    },

    "2026-8-20": {
        texto: "Reunión",
        tipo: "negro"
    },

    "2026-8-25": {
        texto: "Actividad académica",
        tipo: "gris"
    }

};


/* FUNCIÓN PARA CREAR EL CALENDARIO */

// Esta función es la encargada de construir
// visualmente el calendario.
function crearCalendario() {

    // Primero limpiamos los días que ya estaban mostrados
    diasCalendario.innerHTML = "";


    /* ACTUALIZAR TÍTULO */

    // Cambiamos el título para mostrar el mes y el año que estamos viendo actualmente
    tituloMes.textContent =
        `${nombresMeses[mesActual]} ${añoActual}`;


    /* PRIMER DÍA DEL MES */

    // Creamos una fecha usando el año actual,
    const primerDia =
        new Date(añoActual, mesActual, 1);


    /* ÚLTIMO DÍA DEL MES */
    const ultimoDia =
        new Date(añoActual, mesActual + 1, 0);


    /* DÍA DE LA SEMANA EN QUE COMIENZA */

    // getDay nos dice en qué día de la semana comienza el mes
    const primerDiaSemana =
        primerDia.getDay();


    /* CANTIDAD DE DÍAS DEL MES */

    // getDate nos da el número del último día
    const cantidadDias =
        ultimoDia.getDate();


    /* ESPACIOS ANTES DEL PRIMER DÍA */

    // Creamos espacios vacíos
    for (let i = 0; i < primerDiaSemana; i++) {

        // Creamos un nuevo espacio en HTML.
        const espacio =
            document.createElement("div");

        espacio.classList.add("dia", "dia--vacio");

        // Agregamos ese espacio al calendario.
        diasCalendario.appendChild(espacio);
    }


    /* CREAR CADA DÍA */

    for (let dia = 1; dia <= cantidadDias; dia++) {

        // Creamos un nuevo elemento para representar cada día del calendario
        const elementoDia =
            document.createElement("div");


        // Le agregamos la clase "dia" para que tome los estilos del CSS.
        elementoDia.classList.add("dia");


        /* NÚMERO DEL DÍA */

        // Creamos un elemento para colocar el número del día.
        const numeroDia =
            document.createElement("span");

        // Le agregamos la clase correspondiente al número del día.
        numeroDia.classList.add("dia__numero");

        // Colocamos el número dentro del elemento.
        numeroDia.textContent = dia;


        // Metemos el número dentro de la casilla del día.
        elementoDia.appendChild(numeroDia);


        /* COMPROBAR SI ES HOY */
        const hoy = new Date();
        if (
            dia === hoy.getDate() &&
            mesActual === hoy.getMonth() &&
            añoActual === hoy.getFullYear()
        ) {

            elementoDia.classList.add("dia--hoy");

        }


        /* BUSCAR EVENTOS */

        // Creamos una clave usando el año, mes y día.
        // La usamos para buscar si existe un evento para esa fecha
        const claveEvento =
            `${añoActual}-${mesActual + 1}-${dia}`;


        // Buscamos dentro de la lista de eventos si existe una actividad para ese día.
        const evento =
            eventos[claveEvento];


        /* MOSTRAR EVENTO */

        // Si encontramos un evento para ese día...
        if (evento) {

            const elementoEvento =
                document.createElement("span");

            elementoEvento.classList.add(
                "evento",
                `evento--${evento.tipo}`
            );

            // Colocamos el texto de la actividad.
            elementoEvento.textContent =
                evento.texto;


            // Agregamos el evento dentro de la casilla del día.
            elementoDia.appendChild(
                elementoEvento
            );

        }


        /* AGREGAR DÍA AL CALENDARIO */

        diasCalendario.appendChild(
            elementoDia
        );

    }

}


/* BOTÓN MES ANTERIOR */

botonAnterior.addEventListener("click", function () {

    // Restamos 1 al mes actual.
    mesActual--;

    // Si pasamos antes de enero...
    if (mesActual < 0) {

        // Volvemos al mes 11, que es diciembre.
        mesActual = 11;

        // Y también retrocedemos un año.
        añoActual--;

    }

    // Volvemos a crear el calendario para mostrar el nuevo mes
    crearCalendario();

});


/* BOTÓN MES SIGUIENTE */

// Detectamos cuando el usuario hace clic en el botón del mes siguiente.
botonSiguiente.addEventListener("click", function () {

    // Sumamos 1 al mes actual.
    mesActual++;

    // Si pasamos después de diciembre...
    if (mesActual > 11) {

        // Volvemos al mes 0, que es enero.
        mesActual = 0;

        // Y avanzamos un año.
        añoActual++;

    }
    crearCalendario();

});


/* INICIAR CALENDARIO */

crearCalendario();