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

// Los eventos llegan desde la base de datos en la variable EVENTOS
// (la crea la página calendario.html).
// Aquí los agrupamos por fecha, porque un mismo día puede tener
// eventos de varios grupos.
const eventos = {};

for (const evento of (typeof EVENTOS !== "undefined" ? EVENTOS : [])) {

    if (!eventos[evento.fecha]) {
        eventos[evento.fecha] = [];
    }

    eventos[evento.fecha].push(evento);
}

// Buscamos la lista donde se muestran los eventos del mes
const listaEventos = document.getElementById("listaEventos");


// Convierte un número como 7 en "07"
function dosDigitos(numero) {
    return String(numero).padStart(2, "0");
}


// Texto que se ve al pasar el mouse sobre un evento
function textoDelEvento(evento) {

    let texto = evento.titulo;

    if (evento.grupo) {
        texto += " · " + evento.grupo;
    }

    if (evento.descripcion) {
        texto += "\n" + evento.descripcion;
    }

    return texto;
}


/* FUNCIÓN PARA CREAR EL CALENDARIO */

// Esta función es la encargada de construir
// visualmente el calendario.
function crearCalendario() {

    // Primero limpiamos los días que ya estaban mostrados
    diasCalendario.innerHTML = "";

    // Y también la lista de eventos del mes anterior
    listaEventos.innerHTML = "";


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

        // Creamos una clave con el año, mes y día (por ejemplo "2026-08-07").
        // La usamos para buscar si hay eventos para esa fecha
        const claveEvento =
            `${añoActual}-${dosDigitos(mesActual + 1)}-${dosDigitos(dia)}`;


        // Buscamos los eventos de ese día (puede haber varios).
        const eventosDelDia =
            eventos[claveEvento] || [];


        /* MOSTRAR EVENTOS */

        for (const evento of eventosDelDia) {

            const elementoEvento =
                document.createElement("span");

            elementoEvento.classList.add(
                "evento",
                `evento--${evento.tipo}`
            );

            // Colocamos el título de la actividad.
            elementoEvento.textContent =
                evento.titulo;

            // Al pasar el mouse se ve el grupo y la descripción.
            elementoEvento.title =
                textoDelEvento(evento);


            // Agregamos el evento dentro de la casilla del día.
            elementoDia.appendChild(
                elementoEvento
            );


            /* AGREGAR A LA LISTA DEL MES */

            const itemLista =
                document.createElement("li");

            const marca =
                document.createElement("span");
            marca.classList.add("evento", `evento--${evento.tipo}`, "lista-eventos__fecha");
            marca.textContent = `${dosDigitos(dia)}/${dosDigitos(mesActual + 1)}`;

            const detalle =
                document.createElement("span");
            detalle.textContent = textoDelEvento(evento).replace("\n", " — ");

            itemLista.appendChild(marca);
            itemLista.appendChild(detalle);
            listaEventos.appendChild(itemLista);

        }


        /* AGREGAR DÍA AL CALENDARIO */

        diasCalendario.appendChild(
            elementoDia
        );

    }


    /* MES SIN EVENTOS */

    if (listaEventos.children.length === 0) {

        const vacio =
            document.createElement("li");

        vacio.textContent = "No hay eventos este mes.";
        listaEventos.appendChild(vacio);
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