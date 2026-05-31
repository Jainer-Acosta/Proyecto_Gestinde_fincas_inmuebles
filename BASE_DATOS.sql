-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para gestion_inmuebles
CREATE DATABASE IF NOT EXISTS `gestion_inmuebles` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `gestion_inmuebles`;

-- Volcando estructura para tabla gestion_inmuebles.alquiler
CREATE TABLE IF NOT EXISTS `alquiler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inquilino_id` int(11) NOT NULL,
  `unidad_inmueble_id` int(11) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` enum('ACTIVO','FINALIZADO') DEFAULT 'ACTIVO',
  PRIMARY KEY (`id`),
  KEY `inquilino_id` (`inquilino_id`),
  KEY `fk_unidad_alquiler` (`unidad_inmueble_id`),
  CONSTRAINT `alquiler_ibfk_1` FOREIGN KEY (`inquilino_id`) REFERENCES `inquilino` (`id`),
  CONSTRAINT `fk_unidad_alquiler` FOREIGN KEY (`unidad_inmueble_id`) REFERENCES `unidad_inmueble` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.alquiler: ~5 rows (aproximadamente)
INSERT INTO `alquiler` (`id`, `inquilino_id`, `unidad_inmueble_id`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
	(1, 2, 1, '2026-05-27', '2026-05-30', 'FINALIZADO'),
	(2, 2, 1, '2026-05-30', '2026-05-31', 'FINALIZADO'),
	(3, 2, 1, '2026-05-30', '2026-06-06', 'ACTIVO'),
	(4, 7, 3, '2026-05-30', '2026-06-06', 'ACTIVO'),
	(5, 3, 4, '2026-05-31', '2026-06-06', 'ACTIVO');

-- Volcando estructura para tabla gestion_inmuebles.banco
CREATE TABLE IF NOT EXISTS `banco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.banco: ~3 rows (aproximadamente)
INSERT INTO `banco` (`id`, `nombre`) VALUES
	(1, 'Bancolombia'),
	(2, 'Davivienda'),
	(3, 'BBVA');

-- Volcando estructura para tabla gestion_inmuebles.configuracion_general
CREATE TABLE IF NOT EXISTS `configuracion_general` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clave` varchar(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT curdate(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.configuracion_general: ~2 rows (aproximadamente)
INSERT INTO `configuracion_general` (`id`, `clave`, `valor`, `descripcion`, `fecha_actualizacion`) VALUES
	(1, 'IVA', 19.00, 'Impuesto al Valor Agregado (%)', '2026-05-30'),
	(4, 'IPC_2026', 2.50, 'IPC aplicable para el año 2026', '2026-05-30');

-- Volcando estructura para tabla gestion_inmuebles.cuenta_bancaria
CREATE TABLE IF NOT EXISTS `cuenta_bancaria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero_cuenta` varchar(50) DEFAULT NULL,
  `saldo` decimal(12,2) DEFAULT 0.00,
  `banco_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_cuenta` (`numero_cuenta`),
  KEY `banco_id` (`banco_id`),
  CONSTRAINT `cuenta_bancaria_ibfk_1` FOREIGN KEY (`banco_id`) REFERENCES `banco` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.cuenta_bancaria: ~2 rows (aproximadamente)
INSERT INTO `cuenta_bancaria` (`id`, `numero_cuenta`, `saldo`, `banco_id`) VALUES
	(1, '103', 6500000.00, 1),
	(2, '1000000', 1000000000.00, 3);

-- Volcando estructura para tabla gestion_inmuebles.edificio
CREATE TABLE IF NOT EXISTS `edificio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `codigo_postal` varchar(20) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `estado` enum('DISPONIBLE','NO DISPONIBLE') DEFAULT 'DISPONIBLE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.edificio: ~4 rows (aproximadamente)
INSERT INTO `edificio` (`id`, `nombre`, `direccion`, `numero`, `codigo_postal`, `ciudad`, `estado`) VALUES
	(1, 'Jainer', 'calle 48', '4b03', '8003', 'Soledad', 'NO DISPONIBLE'),
	(2, 'PCA', 'K38', '76', '8001', 'Barranquilla', 'DISPONIBLE'),
	(3, 'Superrrr', 'calle 48', '4b03', '8003', 'Soledad', 'DISPONIBLE'),
	(4, 'El sol El sol', 'Calle 48 ', '4b03', '8003', 'Soledad', 'DISPONIBLE');

-- Volcando estructura para tabla gestion_inmuebles.inquilino
CREATE TABLE IF NOT EXISTS `inquilino` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `edad` int(11) DEFAULT NULL,
  `sexo` enum('MASCULINO','FEMENINO','OTRO') DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fotografia` varchar(255) NOT NULL,
  `estado` enum('ACTIVO','INACTIVO') DEFAULT 'ACTIVO',
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni` (`dni`),
  KEY `fk_inquilino_usuario` (`usuario_id`),
  CONSTRAINT `fk_inquilino_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.inquilino: ~5 rows (aproximadamente)
INSERT INTO `inquilino` (`id`, `nombre`, `apellido`, `dni`, `edad`, `sexo`, `telefono`, `email`, `fotografia`, `estado`, `usuario_id`, `fecha_registro`) VALUES
	(2, 'San', 'Trocha', '10', 20, 'MASCULINO', '3013540316', 'jainer.acostat@pca.edu.co', '1779474441669.jpg', 'ACTIVO', NULL, '2026-05-31'),
	(3, 'Nico', 'Trocha', '11', 21, 'MASCULINO', '3013540316', 'jainer.acostat@pca.edu.co', '1779475570772.jpg', 'ACTIVO', NULL, '2026-05-31'),
	(4, 'Luis', 'Trocha', '12', 23, 'MASCULINO', '3013540', 'jainer.acostat@pca.edu.co', 'default.png', 'INACTIVO', NULL, '2026-05-31'),
	(6, 'Jainer', 'Trocha', '15', 11, 'MASCULINO', '3013540316', 'jainer.acostat@pca.edu.co', '1779476329522.jpg', 'ACTIVO', NULL, '2026-05-31'),
	(7, 'Jose', 'Jose', '11111', 20, 'MASCULINO', '3013540', 'josejose@gmail.com', '1780170690833.jpg', 'ACTIVO', 2, '2026-05-30');

-- Volcando estructura para tabla gestion_inmuebles.movimiento_bancario
CREATE TABLE IF NOT EXISTS `movimiento_bancario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta_id` int(11) NOT NULL,
  `unidad_inmueble_id` int(11) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `concepto` varchar(100) DEFAULT NULL,
  `monto` double DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cuenta_id` (`cuenta_id`),
  KEY `unidad_inmueble_id` (`unidad_inmueble_id`),
  CONSTRAINT `movimiento_bancario_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuenta_bancaria` (`id`),
  CONSTRAINT `movimiento_bancario_ibfk_2` FOREIGN KEY (`unidad_inmueble_id`) REFERENCES `unidad_inmueble` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.movimiento_bancario: ~2 rows (aproximadamente)
INSERT INTO `movimiento_bancario` (`id`, `cuenta_id`, `unidad_inmueble_id`, `tipo`, `concepto`, `monto`, `fecha`, `descripcion`, `categoria`) VALUES
	(1, 1, 2, 'INGRESO', 'Pago del alquiler', 10000000, '2026-05-30', '', 'ARRIENDO'),
	(2, 1, 3, 'GASTO', 'Reparacion de suelo', 5000000, '2026-05-30', '', 'REPARACION');

-- Volcando estructura para tabla gestion_inmuebles.recibo
CREATE TABLE IF NOT EXISTS `recibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alquiler_id` int(11) NOT NULL,
  `fecha_emision` date NOT NULL,
  `renta` decimal(10,2) DEFAULT 0.00,
  `agua` decimal(10,2) DEFAULT 0.00,
  `luz` decimal(10,2) DEFAULT 0.00,
  `iva` decimal(10,2) DEFAULT 0.00,
  `porteria` decimal(10,2) DEFAULT 0.00,
  `ipc` decimal(10,2) DEFAULT 0.00,
  `otros` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT 0.00,
  `estado` enum('PENDIENTE','PAGADO') DEFAULT 'PENDIENTE',
  `numero_recibo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_recibo` (`numero_recibo`),
  KEY `alquiler_id` (`alquiler_id`),
  CONSTRAINT `recibo_ibfk_1` FOREIGN KEY (`alquiler_id`) REFERENCES `alquiler` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.recibo: ~9 rows (aproximadamente)
INSERT INTO `recibo` (`id`, `alquiler_id`, `fecha_emision`, `renta`, `agua`, `luz`, `iva`, `porteria`, `ipc`, `otros`, `total`, `estado`, `numero_recibo`) VALUES
	(0, 4, '2026-05-31', 1000.00, 1000.00, 10000.00, 18.00, 1000.00, 69.00, 100.00, 13187.00, 'PAGADO', 'SUPERRRR-OFICINA-5102-001'),
	(1, 1, '2026-05-23', 1000.00, 2000.00, 3000.00, 19.00, 5000.00, 0.22, 7000.00, 18019.22, 'PAGADO', 'PCA-PISO-5b-001'),
	(6, 4, '2026-07-01', 1000.00, 1000.00, 10000.00, 18.00, 1000.00, 69.00, 100.00, 13187.00, 'PENDIENTE', 'SUPERRRR-OFICINA-5102-002'),
	(7, 1, '2026-07-01', 1000.00, 2000.00, 3000.00, 19.00, 5000.00, 0.22, 7000.00, 18019.22, 'PENDIENTE', 'PCA-PISO-5b-002'),
	(9, 4, '2026-06-01', 1000.00, 1000.00, 10000.00, 18.00, 1000.00, 69.00, 100.00, 13187.00, 'PENDIENTE', 'SUPERRRR-OFICINA-5102-003'),
	(10, 1, '2026-06-01', 1000.00, 2000.00, 3000.00, 19.00, 5000.00, 0.22, 7000.00, 18019.22, 'PENDIENTE', 'PCA-PISO-5b-003'),
	(12, 4, '2026-08-01', 1000.00, 1000.00, 10000.00, 19.00, 1000.00, 2.50, 100.00, 23315.00, 'PENDIENTE', 'SUPERRRR-OFICINA-5102-004'),
	(13, 1, '2026-08-01', 1000.00, 2000.00, 3000.00, 19.00, 5000.00, 2.50, 7000.00, 18215.00, 'PENDIENTE', 'PCA-PISO-5b-004'),
	(15, 5, '2026-05-30', 1000000.00, 20000.00, 100000.00, 0.00, 5000.00, 0.00, 20000.00, 1400000.00, 'PENDIENTE', 'ELSOLELSOL-PISO-1A-001');

-- Volcando estructura para tabla gestion_inmuebles.unidad_inmueble
CREATE TABLE IF NOT EXISTS `unidad_inmueble` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `edificio_id` int(11) NOT NULL,
  `tipo` enum('PISO','LOCAL','OFICINA') NOT NULL,
  `planta` varchar(20) DEFAULT NULL,
  `letra` varchar(20) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` enum('DISPONIBLE','ALQUILADO','NO_DISPONIBLE') DEFAULT 'DISPONIBLE',
  PRIMARY KEY (`id`),
  KEY `edificio_id` (`edificio_id`),
  CONSTRAINT `unidad_inmueble_ibfk_1` FOREIGN KEY (`edificio_id`) REFERENCES `edificio` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.unidad_inmueble: ~4 rows (aproximadamente)
INSERT INTO `unidad_inmueble` (`id`, `edificio_id`, `tipo`, `planta`, `letra`, `descripcion`, `estado`) VALUES
	(1, 2, 'PISO', '5', 'b', 'Habitacion pequeña', 'ALQUILADO'),
	(2, 3, 'LOCAL', '5', '10', 'Grande', 'DISPONIBLE'),
	(3, 3, 'OFICINA', '5', '102', 'Oficina de dos pisos', 'ALQUILADO'),
	(4, 4, 'PISO', '1', 'A', 'Habitacion amplia, vista al mar', 'ALQUILADO');

-- Volcando estructura para tabla gestion_inmuebles.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('ADMIN','SECRETARIO','INQUILINO') DEFAULT 'SECRETARIO',
  `estado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla gestion_inmuebles.usuario: ~3 rows (aproximadamente)
INSERT INTO `usuario` (`id`, `nombre`, `username`, `password`, `rol`, `estado`) VALUES
	(1, 'Administrador', 'admin', '1234', 'ADMIN', NULL),
	(2, 'Jose', 'jose', '123456', 'INQUILINO', 'ACTIVO'),
	(3, 'Secretario', 'secre', '1234', 'SECRETARIO', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
