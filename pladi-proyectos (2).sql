-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-10-2026 a las 12:05:55
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pladi-proyectos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `archivo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `id_proyecto`, `nombre`, `estado`, `archivo`) VALUES
(1, 1, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA  - Grupo 1.docx'),
(2, 1, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto Final Grupo 1.docx'),
(4, 2, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA  Grupo 2.docx'),
(5, 2, 'Anteproyecto', 'Completado', 'documentos/Anteproyecto Final Grupo 2.docx'),
(6, 3, 'Ficha de inscripción ', 'Aprobado', 'documentos/FICHA - Grupo 3.docx'),
(7, 3, 'Anteproyecto', 'Aprobado', 'documentos/ANTEPROYECTO FINAL GRUPO 3...docx'),
(8, 4, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA - Grupo 4.docx'),
(9, 4, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto final grupo 4.docx'),
(10, 5, 'Ficha de inscripción ', 'Aprobado', 'documentos/FICHA- Grupo 5.docx'),
(11, 5, 'Anteproyecto', 'Aprobado', 'documentos/Formato Ante-proyecto Final Grupo 5.docx'),
(12, 6, 'Ficha de inscripción ', 'Aprobado', 'documentos/FICHA - Grupo 6.docx'),
(13, 6, 'Anteproyecto', 'Aprobado', 'documentos/Formato Anteproyecto final grupo 6.docx'),
(14, 7, 'Ficha de inscripción ', 'Aprobado', 'documentos/FICHA- Grupo 7.docx'),
(15, 7, 'Anteproyecto', 'Aprobado', 'documentos/Formato Anteproyecto final grupo 7.docx'),
(16, 8, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA- Grupo 8.docx'),
(17, 8, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto final grupo 8.docx'),
(18, 9, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA- Grupo 9.docx'),
(19, 9, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto grupo 9.docx'),
(20, 19, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA - Grupo 19.docx'),
(21, 19, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto grupo 19.docx'),
(22, 20, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA - Grupo 20.docx\r\n'),
(23, 20, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto grupo 20.docx'),
(24, 21, 'Ficha de inscripción ', 'Aprobado', 'documentos/FICHA - Grupo 21.docx'),
(25, 21, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto grupo 21.docx'),
(26, 22, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA - Grupo 22.docx\r\n'),
(27, 22, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto final grupo 22.docx'),
(28, 23, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA  - Grupo 23.docx'),
(29, 23, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto_Grupo23. (1).docx'),
(30, 24, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA - Grupo 24.docx'),
(31, 24, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto Grupo 24.docx\r\n'),
(32, 26, 'Ficha de inscripción', 'Aprobado', 'documento/FICHA- Grupo 26.docx\r\n'),
(33, 26, 'Anteproyecto', 'Aprobado', 'documentos/Formato Anteproyecto grupo26.docx'),
(34, 27, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA Grupo 27.docx'),
(35, 27, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto Grupo 27.docx\r\n'),
(36, 28, 'Ficha de inscripción', 'Aprobado', 'documentos/FICHA - Grupo 28.docx'),
(37, 28, 'Anteproyecto', 'Aprobado', 'documentos/Anteproyecto Grupo 28.docx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria`
--

CREATE TABLE `galeria` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  `evidencias` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `galeria`
--

INSERT INTO `galeria` (`id`, `id_proyecto`, `evidencias`) VALUES
(2, 1, 'imagenes/Grupo1-1.png'),
(3, 1, 'imagenes/Grupo1-2.png'),
(4, 1, 'imagenes/Grupo1-3.png'),
(5, 2, 'imagenes/Grupo2-3.png'),
(6, 2, 'imagenes/Grupo2-1.png'),
(7, 2, 'imagenes/Grupo2-2.png'),
(8, 4, 'imagenes/Grupo4-1.png'),
(9, 4, 'imagenes/Grupo4-2.png'),
(10, 4, 'imagenes/Grupo4-3.png'),
(11, 5, 'imagenes/Grupo5-1.png'),
(12, 5, 'imagenes/Grupo5-2.png'),
(13, 5, 'imagenes/Grupo5-3.png'),
(14, 6, 'imagenes/Grupo6-1.png'),
(15, 6, 'imagenes/Grupo6-2.png'),
(16, 6, 'imagenes/Grupo6-3.png'),
(17, 7, 'imagenes/Grupo7-3.png'),
(18, 7, 'imagenes/Grupo7-2.png'),
(19, 7, 'imagenes/Grupo7-1.png'),
(20, 8, 'imagenes/Grupo8-1.png'),
(21, 8, 'imagenes/Grupo8-2.png'),
(22, 8, 'imagenes/Grupo8-3.png'),
(23, 9, 'imagenes/Grupo9-3.png'),
(24, 9, 'imagenes/Grupo9-1.png'),
(25, 9, 'imagenes/Grupo9-2.png'),
(26, 19, 'imagenes/Grupo19-1.png'),
(27, 19, 'imagenes/Grupo19-2.png'),
(28, 19, 'imagenes/Grupo19-3.png'),
(29, 20, 'imagenes/Grupo20-1.png'),
(30, 20, 'imagenes/Grupo20-2.png'),
(31, 20, 'imagenes/Grupo20-3.png'),
(32, 21, 'imagenes/Grupo21-3.png'),
(33, 21, 'imagenes/Grupo21-1.png'),
(34, 21, 'imagenes/Grupo21-2.png'),
(35, 23, 'imagenes/Grupo23-1.png'),
(36, 23, 'imagenes/Grupo23-2.png'),
(37, 23, 'imagenes/Grupo23-3.png'),
(38, 24, 'imagenes/Grupo24-3.png'),
(39, 24, 'imagenes/Grupo24-1.png'),
(40, 24, 'imagenes/Grupo24-2.png'),
(41, 26, 'imagenes/Grupo26-3.png'),
(42, 26, 'imagenes/Grupo26-1.png'),
(43, 26, 'imagenes/Grupo26-2.png'),
(44, 27, 'imagenes/Grupo27-3.png'),
(45, 27, 'imagenes/Grupo27-1.png'),
(46, 27, 'imagenes/Grupo27-2.png'),
(47, 28, 'imagenes/Grupo28-1.png'),
(48, 28, 'imagenes/Grupo28-2.png'),
(49, 3, 'imagenes/Grupo3-3.png'),
(50, 3, 'imagenes/Grupo3-1.png'),
(51, 3, 'imagenes/Grupo3-2.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `integrantes`
--

CREATE TABLE `integrantes` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `foto` text DEFAULT NULL,
  `rol` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `integrantes`
--

INSERT INTO `integrantes` (`id`, `id_proyecto`, `nombre`, `foto`, `rol`) VALUES
(1, 1, 'ALCANTAR CAICEDO ROGER STEPHAN', NULL, 'Lider'),
(2, 1, 'PARADA ZARATE LUCIANA', NULL, NULL),
(3, 1, 'PRIETO SETINA JENIFER MARIANA', NULL, NULL),
(4, 2, 'CALVERA REINA EMMANUEL ALEJANDRO', NULL, NULL),
(5, 2, 'CAMARGO BAUTISTA KAROL ESTEFANÍA', NULL, NULL),
(6, 2, 'CAMARGO BAUTISTA LISETH PAOLA', NULL, NULL),
(7, 2, 'SILVA SANABRIA SANTIAGO', NULL, NULL),
(8, 3, 'GUZMÁN NIÑO MICHAEL STEVEN', NULL, NULL),
(9, 3, 'ROMERO REUTO ADRIANA VALENTINA', NULL, NULL),
(10, 3, 'MONTEALEGRE GARCIA KAROL DAYANNA', NULL, NULL),
(11, 4, 'CORREA MEJIA JAVIER JOSUE', NULL, NULL),
(12, 4, 'CORREA MEJIA LIZETH FABIOLA', NULL, NULL),
(13, 4, 'PEREZ RODRIGUEZ ERIKA NATALIA', NULL, NULL),
(14, 4, 'GOMEZ POVEDA JUAN CARLOS', NULL, NULL),
(15, 5, 'COMEZAQUIRA FUENTES MONICA MILENA', NULL, NULL),
(16, 5, 'IBICA NARANJO MAYRA SOFIA', NULL, NULL),
(17, 5, 'VEGA APONTE JHONFER YASSET', NULL, NULL),
(18, 6, 'CARRILLO VERA BRENDA SOFIA', NULL, NULL),
(19, 6, 'LEVA GARZON YOSMAR SNEIDER', NULL, NULL),
(20, 6, 'NOVOA ROMERO JONATAN JAHIR', NULL, NULL),
(21, 7, 'DUARTE VALCARCEL MARIA ZAJHAR', NULL, NULL),
(22, 7, 'JAIMES SERRANO JALID JOANA', NULL, NULL),
(23, 7, 'LEVA GARZON ASTRITH YUREI', NULL, NULL),
(24, 8, 'GOMEZ SANTOS DUVAN YESID', NULL, NULL),
(25, 8, 'NIÑO TORRES ANDRES FELIPE', NULL, NULL),
(26, 8, 'SANCHEZ SUAREZ CARLOS ESTIVEN', NULL, NULL),
(27, 9, 'BAQUERO MARIÑO FREDERICK ALESSANDRO', NULL, NULL),
(28, 9, 'BUSTAMANTE RIOS ZUAMY JULIETH', NULL, NULL),
(29, 9, 'VASQUEZ PINZON SHARON DANIELA', NULL, NULL),
(30, 19, 'AMADOR GONZALEZ VALERY NIKOLLE', NULL, NULL),
(31, 19, 'HUELGOS BALLONA ANGELICA DASLEY', NULL, NULL),
(32, 20, 'AMAYA MARQUEZ KERLON ALEJANDRO', NULL, NULL),
(33, 20, 'BENITES ACOSTA JULIETH ALEXANDRA', NULL, NULL),
(34, 20, 'SANTOS GOMEZ NICOLE VALERIA', NULL, NULL),
(35, 21, 'AVELLANEDA TELLEZ SANTIAGO ANDRES', NULL, NULL),
(36, 21, 'CARRILLO BUSTOS HEYDIS DAYANA', NULL, NULL),
(37, 21, 'TORRADO LAGOS YAIRA YINETH', NULL, NULL),
(38, 21, 'MENDOZA MONA THOMAS DANIEL', NULL, NULL),
(39, 22, 'CAMACHO ORTEGA KARLA YINETH', NULL, NULL),
(40, 22, 'LEAL LIEVANO JHOANN CAMILO', NULL, NULL),
(41, 22, 'TORRES DÁVILA TOMAS FELIPE', NULL, NULL),
(45, 24, 'CORREA RIVERO KATHERIN YICED', NULL, NULL),
(46, 24, 'CURBELO RUBIO DAVID AVIASAF', NULL, NULL),
(47, 24, 'PEREZ PORTILLO IAN FELIPE', NULL, NULL),
(48, 26, 'CASTILLO GARCIA DINER ZAMMIR', NULL, NULL),
(49, 26, 'PINO ZERPA EMILY ALEXA', NULL, NULL),
(50, 26, 'SEPULVEDA URIBE EDWIN ALEJANDRO', NULL, NULL),
(51, 26, 'VERGARA LEON ALEJANDRO', NULL, NULL),
(52, 27, 'POVEDA ORTIZ JHON ALEX', NULL, NULL),
(53, 27, 'SARMIENTO CASTELLANOS SARA SOFIA', NULL, NULL),
(54, 27, 'VERGARA PEREZ ANDRES GIOVANNY', NULL, NULL),
(55, 27, 'USUGA VEGA SAHELY DARIANA', NULL, NULL),
(56, 28, 'ALBA LINARES MARIANGEL', NULL, NULL),
(57, 28, 'ANTOLINEZ BRAGAGNINI MARIA JOSE', NULL, NULL),
(58, 28, 'NUÑEZ VILLAMIZAR GABRIEL ANTONIO', NULL, NULL),
(59, 28, 'ROMERO CASTILLO JUAN DAVID', NULL, NULL),
(76, 23, 'BELLO MENDOZA JINEY SOFÍA', NULL, NULL),
(77, 23, 'HERNANDEZ CASTILLO YURI CAMILA', NULL, NULL),
(78, 23, 'VERA CASTELLANOS CHARID SIRLEY', NULL, NULL),
(79, 23, 'verita', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos_especificos`
--

CREATE TABLE `objetivos_especificos` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `objetivos_especificos`
--

INSERT INTO `objetivos_especificos` (`id`, `id_proyecto`, `descripcion`) VALUES
(1, 1, 'Diseñar una base de datos en MySQL que permita mejorar la gestión del inventario y los préstamos de la biblioteca, aplicando comandos, técnicas y pruebas que garanticen su correcto funcionamiento. '),
(2, 1, 'Conectar la base de datos con Python para optimizar el manejo, consulta y procesamiento de la información.'),
(3, 1, 'Implementar una interfaz gráfica en Streamlit que facilite la interacción con el sistema y el acceso a la información.'),
(4, 1, 'Capacitar a la bibliotecaria mediante la implementación del sistema, garantizando su uso autónomo y eficiente en las actividades diarias.'),
(5, 2, 'Identificar los requerimientos técnicos necesarios para el diseño de un sistema de riego automatizado por goteo en la granja de la Institución Educativa Liceo Tame.'),
(6, 2, 'Diseñar el sistema de riego automatizado utilizando tuberías, electroválvulas, relés y programación con ESP32 para controlar los horarios de riego.'),
(7, 2, 'Implementar y probar el sistema de riego automatizado por goteo  con el fin de verificar su funcionamiento y mejorar la eficiencia del riego en los cultivos de la granja.'),
(8, 3, 'Identificar los contenidos básicos de electrónica que deben ser incluidos en el sitio web educativo.'),
(9, 3, 'Diseñar la estructura y organización del sitio web para facilitar la comprensión de los contenidos.'),
(10, 3, 'Desarrollar el sitio web educativo utilizando herramientas de programación y tecnologías digitales.'),
(11, 3, 'Evaluar el funcionamiento del sitio web como herramienta de apoyo para el aprendizaje de los estudiantes.'),
(12, 4, 'Diseñar el esquema electrónico y la lógica de programación del módulo didáctico, seleccionando los sensores de radiación ultravioleta (ML8511) y temperatura (DHT22) junto con los actuadores (LEDs, buzzer, pantalla LCD Módulo Electrónico Didáctico de Sensores y Actuadores para la Medición de Temperatura Ambiental en Estudiantes de Sexto Grado \r\nD y ventilador) que representen visualmente los niveles de riesgo UV según la escala de la OMS.\r\n'),
(13, 4, 'Construir y programar el módulo electrónico didáctico ensamblando los componentes en una placa de pruebas (protoboard) y codificando las instrucciones en el microcontrolador Arduino UNO, de modo que el sistema monitoree en tiempo real las condiciones ambientales y emita alertas visuales y sonoras según el nivel de riesgo UV y de temperatura detectados.'),
(14, 4, 'Implementar el módulo como herramienta pedagógica en la institución, diseñando y ejecutando una actividad práctica en la que los estudiantes realicen mediciones de radiación UV y temperatura, registren sus observaciones, relacionen los datos obtenidos con el riesgo del cáncer de piel y extraigan conclusiones sobre la importancia de la prevención solar en su entorno.'),
(15, 5, 'Diseñar una torre hidropónica vertical automatizada de acuerdo con las necesidades de la huerta de la Institución Educativa Liceo Tame, optimizando el aprovechamiento del espacio y el uso eficiente del agua. '),
(16, 5, 'Construir e implementar un sistema automatizado de riego mediante componentes electrónicos y programación, que permita suministrar agua a las hortalizas de manera controlada y oportuna. '),
(17, 5, 'Evaluar el funcionamiento de la torre hidropónica vertical automatizada mediante el análisis de su desempeño en el cultivo de hortalizas, considerando aspectos como el ahorro de agua, el aprovechamiento del espacio y el crecimiento de las plantas. '),
(18, 6, 'Diagnosticar las condiciones de los puntos de lavado de manos de la Institución Educativa Liceo Tame, identificando deficiencias en infraestructura, acceso al agua y disponibilidad de jabón.'),
(19, 6, 'Diseñar un dispensador automático o semiautomático de agua y jabón que garantice condiciones adecuadas de higiene y un uso eficiente de los recursos.'),
(20, 6, 'Elaborar los planos técnicos, especificaciones de materiales y presupuesto del sistema dispensador propuesto.'),
(21, 6, 'Implementar el dispensador de agua y jabón en los puntos críticos seleccionados de la institución y verificar su correcto funcionamiento.'),
(22, 7, 'Identificar la información académica y profesional de los docentes necesaria para el desarrollo del sitio web.'),
(23, 7, 'Diseñar la estructura y la interfaz del sitio web de manera clara y accesible para los usuarios.'),
(24, 7, 'Crear una base de datos que permita almacenar y gestionar la información de los docentes.'),
(25, 7, 'Evaluar el funcionamiento del sitio web mediante pruebas para garantizar su correcto uso.'),
(26, 8, 'Identificar las necesidades hídricas de los cultivos presentes en la huerta escolar para determinar los requerimientos del sistema automatizado de riego y nebulización.'),
(27, 8, 'Diseñar e implementar la estructura del sistema automatizado de riego y nebulización en la huerta escolar del Liceo Tame, incluyendo sus componentes electrónicos y mecánicos.\r\n'),
(28, 8, 'Programar el sistema automatizado para controlar los tiempos y la frecuencia de riego de acuerdo con las necesidades de los cultivos.\r\n'),
(29, 8, 'Evaluar el funcionamiento y la efectividad del sistema automatizado en el suministro adecuado de agua a los cultivos.\r\n'),
(30, 9, 'Identificar las dificultades en el aprendizaje de las matemáticas básicas de los estudiantes de séptimo grado de la Institución Educativa Liceo Tame. \r\n'),
(31, 9, 'Diseñar un módulo electrónico pedagógico para el fortalecimiento de temas matemáticos básicos mediante el uso de componentes electrónicos simples. \r\n'),
(32, 9, 'Elaborar un folleto pedagógico que oriente el uso del módulo electrónico en el desarrollo de actividades matemáticas para estudiantes de séptimo grado. \r\n'),
(33, 19, 'Seleccionar herramientas y plataformas gratuitas para el desarrollo y alojamiento del sitio web.'),
(34, 19, 'Construir la estructura básica del sitio web, con secciones esenciales para mostrar productos y recibir pedidos.\r\n'),
(35, 19, 'Configurar funcionalidades clave: catálogo de productos y formulario de pedidos gratuito \r\n'),
(36, 19, 'Capacitar al estudiante emprendedor en el uso y mantenimiento básico del sitio web (actualización de productos, seguimiento de pedidos), sin incluir capacitación en mercadeo.\r\n'),
(37, 20, 'Identificar los datos y la información relevante de los jugadores que participan en los juegos intercursos del Liceo Tame.\r\n'),
(38, 20, 'Programar los módulos de registro y seguimiento de los jugadores dentro de la aplicación.\r\n'),
(39, 20, 'Documentar los resultados y la funcionalidad de la aplicación para garantizar su uso y mantenimiento en la institución.\r\n'),
(40, 21, 'Identificar las necesidades de riego de los cultivos de forraje hidropónico en la granja vocacional del Liceo Tame, con el fin de determinar la cantidad de agua requerida en cada etapa del crecimiento \r\n'),
(41, 21, 'Diseñar un sistema de riego automatizado adecuado, teniendo en cuenta los recursos disponibles y las condiciones del cultivo'),
(42, 21, 'Implementar el sistema de riego automatizado en los cultivos de forraje hidropónico, con el propósito de mejorar su crecimiento y reducir el trabajo manual '),
(43, 22, 'Identificar los requisitos técnicos y funcionales necesarios para los módulos de autenticación, perfiles y administración.\r\n'),
(44, 22, 'Programar la base de datos y los módulos de gestión de perfiles para permitir el registro de información académica, profesional y de contacto.'),
(45, 22, 'Probar el sistema de búsqueda, filtrado y exportación de listados en el panel administrativo para asegurar la eficiencia en la toma de decisiones'),
(51, 24, 'Construir la estructura física de la incubadora que garantice el aislamiento térmico adecuado.\r\n'),
(52, 24, 'Seleccionar los componentes electrónicos necesarios para el control de temperatura, humedad y volteo.'),
(53, 24, 'Aplicar un sistema de monitoreo de las variables internas de la incubadora.'),
(54, 26, 'Diseñar la estructura y el funcionamiento del brazo robótico considerando criterios de uso educativo y movilidad.\r\n'),
(55, 26, 'Programar el sistema de control del brazo robótico para ejecutar movimientos básicos de forma precisa.\r\n'),
(56, 26, 'Implementar el uso del brazo robótico como herramienta didáctica para apoyar los procesos de enseñanza y aprendizaje en la institución.\r\n'),
(57, 27, 'Identificar los requerimientos funcionales y de diseño de la plataforma web mediante el análisis de las necesidades de los emprendedores y pequeñas empresas del municipio de Tame, Arauca. \r\n'),
(58, 27, 'Diseñar la estructura visual e interactiva de la plataforma, garantizando una interfaz atractiva, intuitiva y adaptada a distintos dispositivos, que facilite la experiencia del usuario. \r\n'),
(59, 27, 'Implementar un sistema de gestión de anuncios que permita a los emprendedores actualizar, modificar y administrar su contenido digital de forma autónoma y sencilla. '),
(60, 28, 'Identificar las competencias básicas en informática que requieren los estudiantes del Liceo Tame para su ingreso a la modalidad técnica.\r\n'),
(61, 28, 'Diseñar una plataforma web interactiva que permita evaluar de manera diagnóstica y formativa las competencias de los estudiantes.\r\n'),
(62, 28, 'Evaluar el impacto del sitio web en la orientación y desempeño académico de los estudiantes en la modalidad técnica en informática.\r\n'),
(79, 23, 'Identificar los requerimientos de información necesarios para el diseño de una plataforma web que presente de forma clara y organizada los proyectos de grado de la modalidad PTD.'),
(80, 23, 'Diseñar la estructura visual e informativa de PLADI-PTD, incluyendo las secciones de inicio, proyectos y calendario, con una interfaz accesible y atractiva para la comunidad educativa.'),
(81, 23, 'Desarrollar las funcionalidades de la plataforma web, incluyendo la visualización de estadísticas generales, las tarjetas de proyectos con hoja de vida completa y el calendario de fechas importantes del semestre.'),
(82, 23, 'Evaluar el funcionamiento de la plataforma mediante pruebas de navegación y usabilidad, con el fin de identificar errores y realizar los ajustes necesarios antes de su entrega final.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progreso`
--

CREATE TABLE `progreso` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  `nombre_paso` varchar(150) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `progreso`
--

INSERT INTO `progreso` (`id`, `id_proyecto`, `nombre_paso`, `estado`) VALUES
(1, 1, 'Ficha', 'Completado'),
(2, 1, 'Anteproyecto', 'En proceso'),
(3, 1, 'Video', 'Completado'),
(4, 1, 'Revision#1', 'Con observaciones'),
(5, 1, 'Corrección ', 'Pendiente '),
(6, 1, 'Revisión #2 ', 'Pendiente '),
(7, 1, 'Revisión #3', 'Pendiente '),
(8, 1, 'Pres.Exel', 'Pendiente'),
(9, 1, 'Sustentación ', 'Pendiente '),
(10, 1, 'Doc.final', 'Pendiente '),
(32, 23, 'Ficha', 'Completado'),
(33, 23, 'Anteproyecto', 'Completado'),
(34, 23, 'Video', 'Completado'),
(35, 23, 'Revision#1', 'Con observaciones'),
(36, 23, 'Corrección ', 'En proceso'),
(37, 23, 'Revisión #2 ', 'Pendiente '),
(38, 23, 'Revisión #3', 'Pendiente '),
(39, 23, 'Pres.Exel', 'Pendiente'),
(40, 23, 'Sustentación ', 'Pendiente '),
(41, 23, 'Doc.final', 'Pendiente '),
(42, 2, 'Ficha', 'Completado'),
(43, 2, 'Anteproyecto', 'En proceso'),
(44, 2, 'Video', 'Completado'),
(45, 2, 'Revision#1', 'Con observaciones'),
(46, 2, 'Corrección ', 'Pendiente '),
(47, 2, 'Revisión #2 ', 'Pendiente '),
(48, 2, 'Revisión #3', 'Pendiente '),
(49, 2, 'Pres.Exel', 'Pendiente'),
(50, 2, 'Sustentación ', 'Pendiente '),
(51, 2, 'Doc.final', 'Pendiente '),
(52, 3, 'Ficha', 'Completado'),
(53, 3, 'Anteproyecto', 'En proceso'),
(54, 3, 'Video', 'Completado'),
(55, 3, 'Revision#1', 'Con observaciones'),
(56, 3, 'Corrección ', 'Pendiente '),
(57, 3, 'Revisión #2 ', 'Pendiente '),
(58, 3, 'Revisión #3', 'Pendiente '),
(59, 3, 'Pres.Exel', 'Pendiente'),
(60, 3, 'Sustentación ', 'Pendiente '),
(61, 3, 'Doc.final', 'Pendiente '),
(62, 4, 'Ficha', 'Completado'),
(63, 4, 'Anteproyecto', 'En proceso'),
(64, 4, 'Video', 'Completado'),
(65, 4, 'Revision#1', 'Con observaciones'),
(66, 4, 'Corrección ', 'Pendiente '),
(67, 4, 'Revisión #2 ', 'Pendiente '),
(68, 4, 'Revisión #3', 'Pendiente '),
(69, 4, 'Pres.Exel', 'Pendiente'),
(70, 4, 'Sustentación ', 'Pendiente '),
(71, 4, 'Doc.final', 'Pendiente '),
(72, 5, 'Ficha', 'Completado'),
(73, 5, 'Anteproyecto', 'En proceso'),
(74, 5, 'Video', 'Completado'),
(75, 5, 'Revision#1', 'Con observaciones'),
(76, 5, 'Corrección ', 'Pendiente '),
(77, 5, 'Revisión #2 ', 'Pendiente '),
(78, 5, 'Revisión #3', 'Pendiente '),
(79, 5, 'Pres.Exel', 'Pendiente'),
(80, 5, 'Sustentación ', 'Pendiente '),
(81, 5, 'Doc.final', 'Pendiente '),
(82, 6, 'Ficha', 'Completado'),
(83, 6, 'Anteproyecto', 'En proceso'),
(84, 6, 'Video', 'Completado'),
(85, 6, 'Revision#1', 'Con observaciones'),
(86, 6, 'Corrección ', 'Pendiente '),
(87, 6, 'Revisión #2 ', 'Pendiente '),
(88, 6, 'Revisión #3', 'Pendiente '),
(89, 6, 'Pres.Exel', 'Pendiente'),
(90, 6, 'Sustentación ', 'Pendiente '),
(91, 6, 'Doc.final', 'Pendiente '),
(92, 7, 'Ficha', 'Completado'),
(93, 7, 'Anteproyecto', 'En proceso'),
(94, 7, 'Video', 'Completado'),
(95, 7, 'Revision#1', 'Con observaciones'),
(96, 7, 'Corrección ', 'Pendiente '),
(97, 7, 'Revisión #2 ', 'Pendiente '),
(98, 7, 'Revisión #3', 'Pendiente '),
(99, 7, 'Pres.Exel', 'Pendiente'),
(100, 7, 'Sustentación ', 'Pendiente '),
(101, 7, 'Doc.final', 'Pendiente '),
(102, 8, 'Ficha', 'Completado'),
(103, 8, 'Anteproyecto', 'En proceso'),
(104, 8, 'Video', 'Completado'),
(105, 8, 'Revision#1', 'Con observaciones'),
(106, 8, 'Corrección ', 'Pendiente '),
(107, 8, 'Revisión #2 ', 'Pendiente '),
(108, 8, 'Revisión #3', 'Pendiente '),
(109, 8, 'Pres.Exel', 'Pendiente'),
(110, 8, 'Sustentación ', 'Pendiente '),
(111, 8, 'Doc.final', 'Pendiente '),
(112, 9, 'Ficha', 'Completado'),
(113, 9, 'Anteproyecto', 'En proceso'),
(114, 9, 'Video', 'Completado'),
(115, 9, 'Revision#1', 'Con observaciones'),
(116, 9, 'Corrección ', 'Pendiente '),
(117, 9, 'Revisión #2 ', 'Pendiente '),
(118, 9, 'Revisión #3', 'Pendiente '),
(119, 9, 'Pres.Exel', 'Pendiente'),
(120, 9, 'Sustentación ', 'Pendiente '),
(121, 9, 'Doc.final', 'Pendiente '),
(122, 19, 'Ficha', 'Completado'),
(123, 19, 'Anteproyecto', 'En proceso'),
(124, 19, 'Video', 'Completado'),
(125, 19, 'Revision#1', 'Con observaciones'),
(126, 19, 'Corrección ', 'Pendiente '),
(127, 19, 'Revisión #2 ', 'Pendiente '),
(128, 19, 'Revisión #3', 'Pendiente '),
(129, 19, 'Pres.Exel', 'Pendiente'),
(130, 19, 'Sustentación ', 'Pendiente '),
(131, 19, 'Doc.final', 'Pendiente '),
(132, 20, 'Ficha', 'Completado'),
(133, 20, 'Anteproyecto', 'En proceso'),
(134, 20, 'Video', 'Completado'),
(135, 20, 'Revision#1', 'Con observaciones'),
(136, 20, 'Corrección ', 'Pendiente '),
(137, 20, 'Revisión #2 ', 'Pendiente '),
(138, 20, 'Revisión #3', 'Pendiente '),
(139, 20, 'Pres.Exel', 'Pendiente'),
(140, 20, 'Sustentación ', 'Pendiente '),
(141, 20, 'Doc.final', 'Pendiente '),
(142, 21, 'Ficha', 'Completado'),
(143, 21, 'Anteproyecto', 'En proceso'),
(144, 21, 'Video', 'Completado'),
(145, 21, 'Revision#1', 'Con observaciones'),
(146, 21, 'Corrección ', 'Pendiente '),
(147, 21, 'Revisión #2 ', 'Pendiente '),
(148, 21, 'Revisión #3', 'Pendiente '),
(149, 21, 'Pres.Exel', 'Pendiente'),
(150, 21, 'Sustentación ', 'Pendiente '),
(151, 21, 'Doc.final', 'Pendiente '),
(152, 22, 'Ficha', 'Completado'),
(153, 22, 'Anteproyecto', 'En proceso'),
(154, 22, 'Video', 'Completado'),
(155, 22, 'Revision#1', 'Con observaciones'),
(156, 22, 'Corrección ', 'Pendiente '),
(157, 22, 'Revisión #2 ', 'Pendiente '),
(158, 22, 'Revisión #3', 'Pendiente '),
(159, 22, 'Pres.Exel', 'Pendiente'),
(160, 22, 'Sustentación ', 'Pendiente '),
(161, 22, 'Doc.final', 'Pendiente '),
(162, 24, 'Ficha', 'Completado'),
(163, 24, 'Anteproyecto', 'En proceso'),
(164, 24, 'Video', 'Completado'),
(165, 24, 'Revision#1', 'Con observaciones'),
(166, 24, 'Corrección ', 'Pendiente '),
(167, 24, 'Revisión #2 ', 'Pendiente '),
(168, 24, 'Revisión #3', 'Pendiente '),
(169, 24, 'Pres.Exel', 'Pendiente'),
(170, 24, 'Sustentación ', 'Pendiente '),
(171, 24, 'Doc.final', 'Pendiente '),
(172, 26, 'Ficha', 'Completado'),
(173, 26, 'Anteproyecto', 'En proceso'),
(174, 26, 'Video', 'Completado'),
(175, 26, 'Revision#1', 'Con observaciones'),
(176, 26, 'Corrección ', 'Pendiente '),
(177, 26, 'Revisión #2 ', 'Pendiente '),
(178, 26, 'Revisión #3', 'Pendiente '),
(179, 26, 'Pres.Exel', 'Pendiente'),
(180, 26, 'Sustentación ', 'Pendiente '),
(181, 26, 'Doc.final', 'Pendiente '),
(182, 27, 'Ficha', 'Completado'),
(183, 27, 'Anteproyecto', 'En proceso'),
(184, 27, 'Video', 'Completado'),
(185, 27, 'Revision#1', 'Con observaciones'),
(186, 27, 'Corrección ', 'Pendiente '),
(187, 27, 'Revisión #2 ', 'Pendiente '),
(188, 27, 'Revisión #3', 'Pendiente '),
(189, 27, 'Pres.Exel', 'Pendiente'),
(190, 27, 'Sustentación ', 'Pendiente '),
(191, 27, 'Doc.final', 'Pendiente '),
(192, 28, 'Ficha', 'Completado'),
(193, 28, 'Anteproyecto', 'En proceso'),
(194, 28, 'Video', 'Completado'),
(195, 28, 'Revision#1', 'Con observaciones'),
(196, 28, 'Corrección ', 'Pendiente '),
(197, 28, 'Revisión #2 ', 'Pendiente '),
(198, 28, 'Revisión #3', 'Pendiente '),
(199, 28, 'Pres.Exel', 'Pendiente'),
(200, 28, 'Sustentación ', 'Pendiente '),
(201, 28, 'Doc.final', 'Pendiente ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(150) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `objetivo_general` text DEFAULT NULL,
  `imagen_principal` text DEFAULT NULL,
  `grado` varchar(6) DEFAULT NULL,
  `año` int(11) DEFAULT NULL,
  `grupo` varchar(10) DEFAULT NULL,
  `imagen_cronograma` text DEFAULT NULL,
  `icono` varchar(10) DEFAULT '?'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `titulo`, `descripcion`, `objetivo_general`, `imagen_principal`, `grado`, `año`, `grupo`, `imagen_cronograma`, `icono`) VALUES
(1, 'Implementación de una plataforma digital de bases de datos para la Biblioteca del Liceo Tame', 'El proyecto consiste en crear una base de datos para la biblioteca escolar que permita organizar la información de los libros, estudiantes y préstamos.', 'Implementar un sistema de base de datos en MYSQL que permita organizar y registrar digitalmente los libros y sus préstamos en la biblioteca del liceo Tame.', 'imagenes/base.jpeg', '1104', 2026, 'Grupo 01', 'imagenes/cronograma grupo1.png', ''),
(2, 'Sistema De Riego Automatizado Por Goteo y Horarios En La Granja De La Institución Educativa Liceo Tame', 'Proyecto que optimiza el riego de los cultivos mediante un sistema automatizado, favoreciendo el ahorro de agua y el cuidado de la granja escolar.', 'Diseñar e implementar un sistema de riego automatizado por goteo para mejorar la eficiencia en el riego de los cultivos y reducir el trabajo manual en la granja de la Institución Educativa Liceo Tame.', NULL, '1104', 2026, 'Grupo_02', 'imagenes/crono-grupo2.png', ''),
(3, 'Desarrollo de Sitio Web Educativo de Electrónica para Agilizar el Aprendizaje de los Estudiantes de Noveno y Décimo en la Institución Educativa Liceo ', 'Desarrollo de un sitio web educativo diseñado para fortalecer el aprendizaje de electrónica en los estudiantes de noveno y décimo, ofreciendo contenido didáctico, recursos interactivos y material de apoyo que facilita la comprensión de los temas.', 'Desarrollar un sitio web educativo interactivo sobre conceptos básicos de electrónica para apoyar el aprendizaje de los estudiantes de noveno y décimo de la Institución Educativa Liceo Tame.', NULL, '1104', 2026, 'Grupo_03', 'imagenes/crono-grupo3.png', ''),
(4, 'Módulo Electrónico Didáctico de Sensores y Actuadores para la Medición de Temperatura Ambiental en Estudiantes de Sexto Grado ', 'Desarrollo de un módulo electrónico didáctico que facilita el aprendizaje de sensores y actuadores, permitiendo a los estudiantes de sexto grado comprender la medición de la temperatura ambiental de forma práctica', 'Desarrollar un sistema de monitoreo ambiental (UV y temperatura) como herramienta pedagógica para fomentar la cultura de prevención solar y el aprendizaje experimental en el Liceo Tame. ', NULL, '1104', 2026, 'Grupo_04', 'imagenes/crono-grupo4.png', ''),
(5, 'Construcción de una Torre Hidropónica Vertical Automatizada para el Cultivo de Hortalizas en la Huerta de la Institución Educativa Liceo Tame', 'Desarrollo de una torre hidropónica vertical automatizada que permite el cultivo de hortalizas de manera eficiente, fomentando la sostenibilidad, el ahorro de recursos y el aprendizaje de técnicas agrícolas innovadoras en la comunidad educativa.', 'Construir una torre hidropónica vertical automatizada para optimizar el riego y el aprovechamiento del espacio en la huerta escolar de la Institución Educativa Liceo Tame.\r\n', NULL, '1104', 2026, 'Grupo_05', 'imagenes/crono-grupo5.png', ''),
(6, 'Desarrollo de  un Dispensador Automático de Agua y Jabón que Mejore la Higiene en la Institución Educativa Liceo Tame', 'Desarrollo de un dispensador automático de agua y jabón diseñado para mejorar las condiciones de higiene en la institución educativa, fomentando el cuidado de la salud y la prevención de enfermedades mediante el lavado adecuado de manos.', 'Desarrollo de un dispensador automático de agua y jabón en un punto de administración de la Institución Educativa Liceo Tame, con el propósito de facilitar una adecuada higiene de manos y contribuir a la prevención de enfermedades.', NULL, '1104', 2026, 'Grupo_06', 'imagenes/crono.png', ''),
(7, 'Desarrollo de un Sitio Web Informativo para la Búsqueda de Información Docente de la Institución Educativa Liceo Tame', 'Desarrollo de un sitio web informativo diseñado para centralizar y organizar la información de los docentes de la Institución Educativa Liceo Tame, facilitando su consulta por parte de estudiantes, padres de familia y comunidad educativa de manera rápida y eficiente.', 'Desarrollar un sitio web informativo que permita centralizar, organizar y facilitar el acceso a la información docente de la Institución Educativa Liceo Tame para mejorar la comunicación y la consulta por parte de la comunidad educativa.', NULL, '1104', 2026, 'Grupo_07', 'imagenes/crono-grupo7.png', ''),
(8, 'Diseño e Implementación de Sistema Automatizado de Riego por Nebulización en la Huerta Escolar del Liceo Tame', 'Este proyecto busca desarrollar un sistema automatizado de riego por nebulización que active el suministro de agua según la humedad del suelo. Su objetivo es optimizar el uso del agua, mejorar el cuidado de los cultivos y promover el aprendizaje en tecnología y sostenibilidad.', 'Diseñar e implementar un sistema automatizado de riego y nebulización para garantizar el suministro adecuado de agua a los cultivos de la huerta escolar del Liceo Tame, mejorando su mantenimiento y reduciendo la necesidad de intervención manual constante.', NULL, '1104', 2026, 'Grupo 08', 'imagenes/crono-grupo8.png', ''),
(9, 'Módulo Electrónico Pedagógico para Fortalecer el Aprendizaje de Matemáticas Básicas en Estudiantes de Séptimo Grado de la Institución Educativa  Liceo', 'Este proyecto consiste en desarrollar un módulo electrónico interactivo que facilite el aprendizaje de las matemáticas básicas en estudiantes de séptimo grado, promoviendo una enseñanza más dinámica, práctica y didáctica.', 'Desarrollar un módulo electrónico pedagógico para facilitar el aprendizaje de matemáticas básicas mediante actividades en estudiantes de séptimo grado de la Institución Educativa Liceo Tame.\r\n', NULL, '1104', 2026, 'Grupo 09', 'imagenes/crono-grupo9.png', ''),
(19, 'Implementación de un Sitio Web informativo para fortalecer el emprendimiento de un estudiante del Liceo Tame', 'Este proyecto busca desarrollar un sitio web informativo para dar a conocer el emprendimiento de un estudiante del Liceo Tame, facilitando la difusión de sus productos o servicios y fortaleciendo su presencia digital.', 'Diseñar e implementar un sitio web completamente gratuito y funcional para la venta de postres del estudiante del Liceo Tame, limitándose exclusivamente a la creación de la plataforma sin realizar actividades de mercadeo o promoción.\r\n', NULL, '1103', 2026, 'Grupo 19', 'imagenes/crono-grupo19.png', ''),
(20, 'Aplicación Digital Integral Para la Organización y Gestión de los Juegos Intercursos  de la Institución Educativa Liceo Tame', 'Este proyecto consiste en desarrollar una aplicación digital que facilite la organización y gestión de los Juegos Intercursos del Liceo Tame, optimizando el registro de equipos, la programación de encuentros y el seguimiento de resultados.', 'Desarrollar una aplicación digital que permita  organizar la información de los jugadores de los juegos intercursos en el Liceo Tame, facilitando su control y seguimiento.\r\n', NULL, '1103', 2026, 'Grupo 20', 'imagenes/crono-grupo20.png', ''),
(21, 'Implementación de un Sistema de Riego Automatizado en Cultivos de Forraje Hidropónico para la huerta del Liceo Tame ', 'Este proyecto busca implementar un sistema de riego automatizado para cultivos de forraje hidropónico, optimizando el uso del agua y mejorando el crecimiento y mantenimiento de los cultivos en la huerta del Liceo Tame.', 'Implementar un sistema de riego automatizado en los cultivos de forraje hidropónico, para optimizar el uso del agua y mejorar el crecimiento de las plantas en la granja vocacional del Liceo Tame.\r\n', NULL, '1103', 2026, 'Grupo 21', 'imagenes/crono-grupo21.png', ''),
(22, 'Implementación de una Aplicación Web para la Gestión de Perfiles de los Egresados del Liceo Tame', 'Este proyecto consiste en desarrollar una aplicación web que permita gestionar y actualizar la información de los egresados del Liceo Tame, facilitando el acceso y la organización de sus perfiles.', 'Desarrollar e implementar una aplicación web para la creación y gestión de perfiles de los egresados del Liceo Tame, que permita centralizar y mantener actualizada la información personal, facilite los procesos administrativos y fortalezca el vínculo entre la institución y su comunidad de exalumnos\r\n', NULL, '1103', 2026, 'Grupo 22', 'imagenes/crono-grupo22.png', ''),
(23, 'Creación de una plataforma digital informativa de proyectos de la modalidad en programación y tecnologías digitales de la Institución Educativa Liceo ', 'centralizar y mostrar información sobre todos los proyectos de grado que desarrollan los estudiantes de la modalidad PTD, facilitando que cualquier persona de la comunidad educativa', 'Desarrollar una plataforma web informativa denominada PLADI-PTD que permita centralizar y visibilizar la información de los proyectos de grado de la modalidad de Programación y Tecnologías Digitales de los estudiantes de undécimo grado de la Institución Educativa Liceo Tame, facilitando su consulta por parte de toda la comunidad educativa.', NULL, '1103', 2026, 'Grupo_23', 'imagenes/croono_23.jpeg', ''),
(24, 'Diseñar e Implementar una Incubadora de Huevos Automatizada para la Granja Vocacional del Liceo Tame', 'Este proyecto busca diseñar e implementar una incubadora de huevos automatizada que controle la temperatura y la humedad, mejorando el proceso de incubación y apoyando las prácticas de aprendizaje en la granja vocacional del Liceo Tame.', 'Diseñar e implementar una incubadora de huevos automatizada que permita mejorar el proceso de incubación y aumentar la tasa de eclosión de huevos de gallina en la granja vocacional del Liceo Tame.', NULL, '1103', 2026, 'Grupo 24', 'imagenes/crono-grupo24.png', ''),
(26, 'Implementación De Un Brazo Robótico Diseñado En Impresión 3D Como Material De Apoyo En La Modalidad Programación Y Tecnologías Digitales Del Liceo Tam', 'Este proyecto consiste en desarrollar un brazo robótico fabricado mediante impresión 3D como herramienta didáctica para fortalecer el aprendizaje de programación, robótica y tecnologías digitales en el Liceo Tame.', 'Diseñar y construir un brazo robótico funcional para fortalecer el aprendizaje práctico en áreas de la modalidad; Programación y Tecnologías Digitales en la Institución Educativa Liceo Tame.\r\n', NULL, '1103', 2026, 'Grupo 26', 'imagenes/crono-grupo26.png', ''),
(27, 'Plataforma Digital para Impulsar, Promocionar y Visibilizar Empresas y Emprendimientos, Facilitando su Crecimiento, Conexión con Clientes y Posicionam', 'Este proyecto busca desarrollar una plataforma digital que permita promocionar empresas y emprendimientos de Tame, Arauca, facilitando su visibilidad, la conexión con clientes y el fortalecimiento de su presencia en el entorno digital.', 'Desarrollar una plataforma web denominada Anuncios con Estilo que permita a los emprendedores y pequeñas empresas del municipio de Tame, Arauca, crear, publicar y gestionar anuncios digitales de manera creativa, accesible y eficiente, con el fin de fortalecer su visibilidad en el entorno digital, consolidar su imagen de marca y facilitar la conexión con su público objetivo, contribuyendo así al crecimiento económico y al posicionamiento digital de los negocios locales.\r\n', NULL, '1103', 2026, 'Grupo 27', 'imagenes/crono-grupo27.png', ''),
(28, 'Desarrollo de un Sitio Web de Evaluación Diagnóstica Formativa para la Orientación a la Modalidad en Programación y Tecnologías Digitales en la Instit', 'Este proyecto consiste en desarrollar un sitio web que permita realizar evaluaciones diagnósticas formativas para orientar a los estudiantes en la modalidad de Programación y Tecnologías Digitales del Liceo Tame.', 'Diseñar un sitio web de evaluación diagnóstica formativa para orientar y nivelar a los estudiantes del Liceo Tame en la modalidad técnica en informática, facilitando la identificación de sus competencias y la toma de decisiones académicas.\r\n', NULL, '1103', 2026, 'Grupo 28', 'imagenes/crono-grupo28.png', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_proyecto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `contrasena`, `id_proyecto`) VALUES
(1, 'charid vera', 'scrypt:32768:8:1$HIAeDcTmbdbzaYue$a8658aa81728c47e768c22f31d4f196f4ba27ef077b67e6ef92ca765c5deb1e21a3fb0802ac52b5cf55227fae91fad1da0023930aea0d91a05d4fc3c1f94729d', 23),
(2, 'royer', 'scrypt:32768:8:1$3Y3o8h8lQLi6CBWy$582cd695703eea8b72f4d50dfc5bc03aadc2c936e5a2338da91d701078919777e46b246e08a32e49052be67a59b27dacf5e06c00ee8639553e92514200906f40', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `galeria`
--
ALTER TABLE `galeria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `integrantes`
--
ALTER TABLE `integrantes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `objetivos_especificos`
--
ALTER TABLE `objetivos_especificos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `progreso`
--
ALTER TABLE `progreso`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD KEY `id_proyecto` (`id_proyecto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `galeria`
--
ALTER TABLE `galeria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de la tabla `integrantes`
--
ALTER TABLE `integrantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT de la tabla `objetivos_especificos`
--
ALTER TABLE `objetivos_especificos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `progreso`
--
ALTER TABLE `progreso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
