-- Tabla de eventos del calendario.
-- Ejecutar UNA sola vez en la base de datos pladi-proyectos
-- (por ejemplo desde phpMyAdmin, en la pestaña SQL).

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Eventos generales que ya estaban en el calendario.
-- No pertenecen a ningún grupo (id_proyecto = NULL), por eso nadie los puede editar desde la página.
INSERT INTO `eventos` (`id_proyecto`, `fecha`, `titulo`, `descripcion`, `tipo`) VALUES
(NULL, '2026-08-07', 'Seguimiento de proyecto', NULL, 'verde'),
(NULL, '2026-08-15', 'Entrega', NULL, 'amarillo'),
(NULL, '2026-08-20', 'Reunión', NULL, 'negro'),
(NULL, '2026-08-25', 'Actividad académica', NULL, 'gris');
