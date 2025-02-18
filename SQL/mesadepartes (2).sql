-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3305
-- Tiempo de generación: 18-02-2025 a las 05:30:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mesadepartes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_documento_01` (IN `xdoc_id` INT)   BEGIN
SELECT tm_documento.doc_id,tm_documento.area_id, tm_area.area_nom, tm_area.area_correo,tm_documento.doc_externo,tm_documento.doc_dni,tm_documento.doc_nom,tm_documento.doc_descrip,tm_documento.tra_id,tm_tramite.tra_nom,tm_documento.tip_id,tm_tipo.tip_nom,tm_documento.user_id,tm_usuario.usu_nomape,tm_usuario.usu_correo,COALESCE(contador.cant,0)as cant, 
CONCAT(DATE_FORMAT(tm_documento.fech_crea,'%m'),'-',DATE_FORMAT(tm_documento.fech_crea,'%Y'),'-',tm_documento.doc_id) AS nrotramite 
from tm_documento INNER JOIN tm_area on tm_documento.area_id=tm_area.area_id INNER JOIN tm_tramite on tm_documento.tra_id=tm_tramite.tra_id INNER JOIN tm_tipo on tm_documento.tip_id=tm_tipo.tip_id INNER JOIN tm_usuario on tm_documento.user_id=tm_usuario.user_id LEFT JOIN(SELECT doc_id, COUNT(*)AS cant FROM td_documento_detalle WHERE doc_id=xdoc_id GROUP BY doc_id) contador on tm_documento.doc_id=contador.doc_id 
WHERE tm_documento.doc_id=xdoc_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_documento_02` (IN `xuser_id` INT)   BEGIN
    SELECT 
        tm_documento.doc_id,
        tm_documento.area_id, 
        tm_area.area_nom, 
        tm_area.area_correo,
        tm_documento.doc_externo,
        tm_documento.doc_dni,
        tm_documento.doc_nom,
        tm_documento.doc_descrip,
        tm_documento.tra_id,
        tm_tramite.tra_nom,
        tm_documento.tip_id,
        tm_tipo.tip_nom,
        tm_documento.user_id,
        tm_usuario.usu_nomape,
        tm_usuario.usu_correo,
        CONCAT(
            DATE_FORMAT(tm_documento.fech_crea, '%m'), 
            '-', 
            DATE_FORMAT(tm_documento.fech_crea, '%Y'), 
            '-', 
            tm_documento.doc_id
        ) AS nrotramite 
    FROM 
        tm_documento 
    INNER JOIN tm_area ON tm_documento.area_id = tm_area.area_id 
    INNER JOIN tm_tramite ON tm_documento.tra_id = tm_tramite.tra_id 
    INNER JOIN tm_tipo ON tm_documento.tip_id = tm_tipo.tip_id 
    INNER JOIN tm_usuario ON tm_documento.user_id = tm_usuario.user_id 
    WHERE 
        tm_documento.user_id = xuser_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento_detalle`
--

CREATE TABLE `td_documento_detalle` (
  `det_id` int(10) NOT NULL,
  `doc_id` int(10) DEFAULT NULL,
  `det_nom` varchar(250) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_documento_detalle`
--

INSERT INTO `td_documento_detalle` (`det_id`, `doc_id`, `det_nom`, `user_id`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 1, 'test.php', 1, NULL, NULL, NULL, 1),
(2, 8, 'C:\\xampp\\tmp\\php3578.tmp', 71, NULL, NULL, NULL, 1),
(3, 9, 'C:\\xampp\\tmp\\php458E.tmp', 71, NULL, NULL, NULL, 1),
(4, 9, 'C:\\xampp\\tmp\\php459F.tmp', 71, NULL, NULL, NULL, 1),
(5, 10, '1. Ficha de Datos.pdf', 71, NULL, NULL, NULL, 1),
(6, 10, '1. Checklist Documentos.pdf', 71, NULL, NULL, NULL, 1),
(7, 10, '3. Documentos a completar.pdf', 71, NULL, NULL, NULL, 1),
(8, 10, 'Carta de Presentación D.I.N.O S.R.L.pdf', 71, NULL, NULL, NULL, 1),
(9, 11, 'HABLEMOS DE SEGURIDAD, SALUD Y MEDIO AMBIENTE - FEBRERO 2025.pdf', 71, NULL, NULL, NULL, 1),
(10, 12, 'DJ.pdf', 71, NULL, NULL, NULL, 1),
(11, 13, '16. DJ HERRERA PAREDES ALMILCAR MICHEL.pdf', 71, NULL, NULL, NULL, 1),
(12, 14, '8aa96068-034a-469b-89ab-6c11564d1303.pdf', 71, NULL, NULL, NULL, 1),
(13, 14, 'GC_I46N_TF_21C1.pdf', 71, NULL, NULL, NULL, 1),
(14, 15, 'Proyecto de Investigación pre final.docx.pdf', 71, '2025-02-02 19:35:48', NULL, NULL, 1),
(15, 15, 'Certificado ACI 2020 -2021MIGUEL ESPINOZA.pdf', 71, '2025-02-02 19:35:48', NULL, NULL, 1),
(16, 16, '104b97d5-f3aa-4c5c-a345-799af415d6f2.pdf', 71, '2025-02-02 19:39:06', NULL, NULL, 1),
(17, 16, 'Anexo 6.pdf', 71, '2025-02-02 19:39:06', NULL, NULL, 1),
(18, 17, '16. DJ HERRERA PAREDES ALMILCAR MICHEL.pdf', 71, '2025-02-02 21:51:16', NULL, NULL, 1),
(19, 18, 'CARGO DE ENTREGA _RISSO.pdf', 71, '2025-02-02 22:01:01', NULL, NULL, 1),
(20, 19, 'HABLEMOS DE SEGURIDAD, SALUD Y MEDIO AMBIENTE - FEBRERO 2025.pdf', 71, '2025-02-04 22:32:06', NULL, NULL, 1),
(21, 19, 'DJ.pdf', 71, '2025-02-04 22:32:06', NULL, NULL, 1),
(22, 20, 'DJ.pdf', 71, '2025-02-04 23:02:23', NULL, NULL, 1),
(23, 20, 'RIT.pdf', 71, '2025-02-04 23:02:23', NULL, NULL, 1),
(24, 20, 'CARGO DE ENTREGA _RISSO.pdf', 71, '2025-02-04 23:02:23', NULL, NULL, 1),
(25, 21, 'CARGO DE ENTREGA _RISSO.pdf', 71, '2025-02-04 23:07:44', NULL, NULL, 1),
(26, 21, '21. CARGO DE ENTREGA REGLAMENTO INTERNO DE TRABAJO.pdf', 71, '2025-02-04 23:07:44', NULL, NULL, 1),
(27, 22, 'ficha, firma y huella20240908_23055471.pdf', 71, '2025-02-04 23:12:07', NULL, NULL, 1),
(28, 22, 'firma y huella.pdf', 71, '2025-02-04 23:12:07', NULL, NULL, 1),
(29, 23, 'Padre_rico_Padre_pobre_Nueva_edición_actualizada_Qué_les_enseñan.pdf', 71, '2025-02-04 23:13:13', NULL, NULL, 1),
(30, 24, 'DJ.pdf', 71, '2025-02-04 23:38:52', NULL, NULL, 1),
(31, 24, 'RIT.pdf', 71, '2025-02-04 23:38:52', NULL, NULL, 1),
(32, 24, 'CARGO DE ENTREGA _RISSO.pdf', 71, '2025-02-04 23:38:52', NULL, NULL, 1),
(33, 24, '21. CARGO DE ENTREGA REGLAMENTO INTERNO DE TRABAJO.pdf', 71, '2025-02-04 23:38:52', NULL, NULL, 1),
(34, 24, '21. CARGO DE ENTREGA REGLAMENTO INTERNO DE TRABAJO (5).pdf', 71, '2025-02-04 23:38:52', NULL, NULL, 1),
(35, 25, 'RIT.pdf', 71, '2025-02-04 23:50:23', NULL, NULL, 1),
(36, 26, 'DJ.pdf', 71, '2025-02-07 21:53:43', NULL, NULL, 1),
(37, 26, 'RIT.pdf', 71, '2025-02-07 21:53:43', NULL, NULL, 1),
(38, 27, 'Declaracion_juradada_documentos_bachiller (1).pdf', 71, '2025-02-08 13:53:07', NULL, NULL, 1),
(39, 28, 'Proyecto de Investigación final.docx.pdf', 71, '2025-02-08 14:21:04', NULL, NULL, 1),
(40, 28, 'CIR_ALT_PFL_20131644524_48855575_1309202421185.pdf', 71, '2025-02-08 14:21:04', NULL, NULL, 1),
(41, 29, 'Programa de Futuros Empresarios.pdf', 82, '2025-02-08 14:26:12', NULL, NULL, 1),
(42, 29, 'Certificados Operadores Bomba de Concreto - CEMENTOS PACASMAYO (1).pdf', 82, '2025-02-08 14:26:12', NULL, NULL, 1),
(43, 30, 'EMO_CHAFLOQUE_LLONTOP__443633_88_removed.pdf', 71, '2025-02-09 16:21:44', NULL, NULL, 1),
(44, 30, 'CAMO_CHAFLOQUE_LLONTOP_443633_81.PDF', 71, '2025-02-09 16:21:44', NULL, NULL, 1),
(45, 31, 'CARGO DE ENTREGA _RISSO.pdf', 100, '2025-02-09 21:22:43', NULL, NULL, 1),
(46, 32, 'RIT.pdf', 96, '2025-02-10 21:22:04', NULL, NULL, 1),
(47, 32, 'CARGO DE ENTREGA _RISSO.pdf', 96, '2025-02-10 21:22:04', NULL, NULL, 1),
(48, 33, 'cv con constancias de practicas_removed.pdf', 96, '2025-02-10 21:32:04', NULL, NULL, 1),
(49, 33, 'S10-s01 RAID.pdf', 96, '2025-02-10 21:32:04', NULL, NULL, 1),
(50, 34, '104b97d5-f3aa-4c5c-a345-799af415d6f2.pdf', 96, '2025-02-10 21:59:55', NULL, NULL, 1),
(51, 35, 'Certificado ACI 2020 -2021 JIMMY PEREZ.pdf', 96, '2025-02-10 22:01:45', NULL, NULL, 1),
(52, 37, 'S11-s01 SAN (1).pdf', 101, '2025-02-10 22:06:34', NULL, NULL, 1),
(53, 38, 'applicant_1054524242_CV_1047880253.pdf', 103, '2025-02-12 02:05:47', NULL, NULL, 1),
(54, 39, 'CAMO_CHAFLOQUE_LLONTOP_443633_81.PDF', 103, '2025-02-16 19:57:36', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_area`
--

CREATE TABLE `tm_area` (
  `area_id` int(11) NOT NULL,
  `area_nom` varchar(50) NOT NULL,
  `area_correo` varchar(50) NOT NULL DEFAULT '1',
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_area`
--

INSERT INTO `tm_area` (`area_id`, `area_nom`, `area_correo`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 'Recursos Humanos (RRHH)', 'seleccionchiclayo@dino.com.pe', '2025-02-04 22:59:52', '2025-02-16 19:55:43', NULL, 1),
(2, 'Finanzas', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(3, 'Marketing', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(4, 'Producción/Operaciones', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(5, 'Ventas', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(6, 'Servicio al Cliente', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(7, 'Tecnología de la Información (TI)', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(8, 'Investigación y Desarrollo (I+D)', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(9, 'Logística', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(10, 'Legal y Cumplimiento', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(12, 'XD98', 'xd98@gmail.com', '2025-02-16 18:56:14', '2025-02-16 19:35:15', '2025-02-16 19:16:11', 1),
(13, 'tipo18', 'tipo12@gmail.com', '2025-02-16 19:37:32', '2025-02-16 19:52:33', '2025-02-16 19:38:37', 1),
(14, 'tipo21', 'tipocuaq@gmail.com', '2025-02-16 19:52:55', '2025-02-16 19:53:15', '2025-02-16 19:53:27', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_documento`
--

CREATE TABLE `tm_documento` (
  `doc_id` int(10) NOT NULL,
  `area_id` int(10) DEFAULT NULL,
  `tra_id` int(10) DEFAULT NULL,
  `doc_externo` varchar(50) DEFAULT NULL,
  `tip_id` int(10) DEFAULT NULL,
  `doc_dni` varchar(50) DEFAULT NULL,
  `doc_nom` varchar(250) DEFAULT NULL,
  `doc_descrip` varchar(500) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_documento`
--

INSERT INTO `tm_documento` (`doc_id`, `area_id`, `tra_id`, `doc_externo`, `tip_id`, `doc_dni`, `doc_nom`, `doc_descrip`, `user_id`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 1, 1, 'TEST', 1, '123456', 'TEST NOMBRE', 'BLA BLA', 1, '2025-02-04 21:50:05', NULL, NULL, 1),
(2, 2, 6, 'abcd', 1, 'deeded', 'eddeed', 'wsswsw', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(3, 2, 2, 'abcd', 1, 'deeded', '', 'hyyhhy', 85, '2025-02-04 21:50:05', NULL, NULL, 1),
(4, 2, 1, 'abcd', 1, 'deeded', 'eddeed', 'Hola papu', 85, '2025-02-04 21:50:05', NULL, NULL, 1),
(5, 2, 1, 'abcd', 2, 'deeded', 'eddeed', 'ujuju', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(6, 2, 1, 'abcd', 2, 'abc', 'dd', 'deedde', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(7, 1, 5, '123de', 1, '123abc', 'eddeed', 'eded', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(8, 2, 1, 'abcd', 1, '777', '777', 'iikki', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(9, 2, 1, '777', 1, '777', '777', 'Suerte', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(10, 2, 1, '777', 2, '123abc', '777', 'Suerte suerte', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(11, 2, 1, '777', 1, 'deeded', 'eddeed', 'ijiji', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(12, 0, 0, '', 2, '777', '777', 'ikik', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(13, 2, 2, '777', 1, '777', '777', 'iubiu', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(14, 7, 2, '777', 1, '777', '777', 'Hola', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(15, 8, 2, '777', 1, 'deeded', 'eddeed', 'fecha', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(16, 2, 2, '777', 2, '777', '777', 'fecha', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(17, 2, 2, 'abcd', 1, 'deeded', 'eddeed', 'trtrt', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(18, 2, 1, '777', 1, '777', '777', '777 suerte', 71, '2025-02-04 21:50:05', NULL, NULL, 1),
(19, 2, 2, '777', 1, '777', '777', 'Prueba 777, exitos.', 71, '2025-02-04 22:32:03', NULL, NULL, 1),
(20, 1, 13, '777', 2, '777', '777', 'Hola777', 71, '2025-02-04 23:02:20', NULL, NULL, 1),
(21, 1, 2, '777', 1, '777', 'eddeed', 'wswwssw', 71, '2025-02-04 23:07:44', NULL, NULL, 1),
(22, 2, 1, '777', 1, '777', '777', 'Hola no hay plata', 71, '2025-02-04 23:12:07', NULL, NULL, 1),
(23, 8, 2, '777', 1, '777', 'eddeed', 'jonoi', 71, '2025-02-04 23:13:13', NULL, NULL, 1),
(24, 8, 1, '777', 1, '777', '777', 'tggt', 71, '2025-02-04 23:38:52', NULL, NULL, 1),
(25, 8, 2, '777', 1, '777', '777', 'yy', 71, '2025-02-04 23:50:23', NULL, NULL, 1),
(26, 2, 2, '777', 1, '777', '777', 'Hola Efrain eres lo máximo.', 71, '2025-02-07 21:53:43', NULL, NULL, 1),
(27, 7, 1, '777', 1, '81859635', 'Postulación', 'Hola, soy Efrain.', 71, '2025-02-08 13:53:07', NULL, NULL, 1),
(28, 8, 1, 'abcd', 1, '777', 'ededde', 'deeded', 71, '2025-02-08 14:21:04', NULL, NULL, 1),
(29, 1, 18, '787', 2, '897', 'Vacaciones Trujillo', 'Vacaciones con mi familia.', 82, '2025-02-08 14:26:12', NULL, NULL, 1),
(30, 7, 1, '184', 1, '84858689', 'Efra', 'Hola, soy Efra.', 71, '2025-02-09 16:21:44', NULL, NULL, 1),
(31, 2, 1, '897', 1, '897', 'eddeed', 'eddedede', 100, '2025-02-09 21:22:43', NULL, NULL, 1),
(32, 2, 2, '985623', 1, '81859586', 'Edita', 'Hola soy Edita', 96, '2025-02-10 21:22:04', NULL, NULL, 1),
(33, 1, 13, '123de', 2, '89874565', 'eddeed', 'Hola soy Anita la huerfanita.', 96, '2025-02-10 21:32:04', NULL, NULL, 1),
(34, 3, 13, '20285', 1, '85868982', 'Jose Carlos', 'Hola que tal, voy al de Marketing', 96, '2025-02-10 21:59:55', NULL, NULL, 1),
(35, 8, 3, 'ededde', 2, 'deed', 'ededed', 'deeded', 96, '2025-02-10 22:01:45', NULL, NULL, 1),
(36, 8, 3, 'deed', 1, 'deeded', 'eded', 'ededed', 96, '2025-02-10 22:02:25', NULL, NULL, 1),
(37, 10, 2, '8459', 1, '895869', 'Edita', 'Hola, soy Edita.', 101, '2025-02-10 22:06:34', NULL, NULL, 1),
(38, 2, 1, 'eededed', 2, 'deeded', 'ededed', 'edededed', 103, '2025-02-12 02:05:47', NULL, NULL, 1),
(39, 1, 3, '77779', 1, '7777', 'buenasuertepapu', 'Buenasuertepapuprueba seeleccion', 103, '2025-02-16 19:57:36', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_rol`
--

CREATE TABLE `tm_rol` (
  `rol_id` int(10) NOT NULL,
  `rol_nom` varchar(50) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_rol`
--

INSERT INTO `tm_rol` (`rol_id`, `rol_nom`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 'Uusario', '2025-02-09 16:12:59', NULL, NULL, 1),
(2, 'Colaborador', '2025-02-09 16:12:59', NULL, NULL, 1),
(3, 'Administrador', '2025-02-09 16:13:50', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_tipo`
--

CREATE TABLE `tm_tipo` (
  `tip_id` int(10) NOT NULL,
  `tip_nom` varchar(50) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_tipo`
--

INSERT INTO `tm_tipo` (`tip_id`, `tip_nom`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 'Natural', '2025-02-14 00:04:10', NULL, NULL, 1),
(2, 'Juridico', '2025-02-14 00:04:10', NULL, NULL, 1),
(3, 'Otro', '2025-02-14 00:04:10', NULL, NULL, 1),
(11, 'test3', '2025-02-16 16:35:51', '2025-02-16 16:35:56', '2025-02-16 16:36:31', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_tramite`
--

CREATE TABLE `tm_tramite` (
  `tra_id` int(11) NOT NULL,
  `tra_nom` varchar(150) NOT NULL,
  `tra_descrip` varchar(300) NOT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_tramite`
--

INSERT INTO `tm_tramite` (`tra_id`, `tra_nom`, `tra_descrip`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 'Recepción de Correspondencia Externa', 'Recepción y distribución de correspondencia externa a la empresa.', '2025-02-17 22:31:49', NULL, NULL, 1),
(2, 'Registro de Quejas o Reclamos de Cliente', 'Proceso para registrar y gestionar quejas o reclamos de los clientes.', '2025-02-17 22:31:49', NULL, NULL, 1),
(3, 'Solicitud de Información Pública', 'Trámite para la solicitud de información pública por parte de los ciudadanos.', '2025-02-17 22:31:49', NULL, NULL, 1),
(4, 'Registro de Contratos y Acuerdos', 'Registro y almacenamiento de contratos y acuerdos firmados por la empresa.', '2025-02-17 22:31:49', NULL, NULL, 1),
(5, 'Solicitud de Autorización para Eventos', 'Trámite para solicitar la autorización de la empresa para la realización de eventos.', '2025-02-17 22:31:49', NULL, NULL, 1),
(6, 'Solicitud de Registro de Proveedores', 'Proceso para solicitar el registro de nuevos proveedores ante la empresa.', '2025-02-17 22:31:49', NULL, NULL, 1),
(7, 'Solicitud de Certificaciones o Documentos', 'Trámite para solicitar certificaciones o documentos oficiales de la empresa.', '2025-02-17 22:31:49', NULL, NULL, 1),
(8, 'Registro de Visitantes', 'Proceso para registrar y autorizar el ingreso de visitantes a las instalaciones de la empresa.', '2025-02-17 22:31:49', NULL, NULL, 1),
(9, 'Solicitud de Facturas o Documentación', 'Trámite para solicitar la emisión de facturas o documentación relacionada.', '2025-02-17 22:31:49', NULL, NULL, 1),
(10, 'Solicitud de Autorización para Viajes de Negocios', 'Solicitud formal para obtener autorización para realizar viajes de negocios.', '2025-02-17 22:31:49', NULL, NULL, 1),
(11, 'Solicitud de Material de Oficina', 'Solicitud de materiales y suministros de oficina para el uso interno del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(12, 'Solicitud de Permiso o Licencia', 'Proceso para solicitar permisos o licencias laborales para colaboradores del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(13, 'Reclamo de Gastos', 'Registro y validación de reembolsos o reclamos de gastos operativos dentro del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(14, 'Solicitud de Equipamientos o Tecnología', 'Trámite para solicitar equipos tecnológicos o herramientas necesarias para el desempeño laboral en el Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(15, 'Solicitud de Mantenimiento o Tecnología', 'Gestión de solicitudes de mantenimiento de equipos o infraestructura tecnológica dentro del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(16, 'Solicitud de Capacitación', 'Proceso para solicitar capacitaciones o programas de formación profesional dentro del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(17, 'Solicitud de Cambio de Turno o Horario', 'Trámite interno para solicitar modificaciones en el turno o horario laboral de los colaboradores.', '2025-02-17 22:31:49', NULL, NULL, 1),
(18, 'Solicitud de Vacaciones', 'Gestión de solicitudes de vacaciones para el personal del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(19, 'Reclamos de Incidentes Laborales', 'Registro y seguimiento de incidentes laborales reportados por los trabajadores del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(20, 'Solicitud de Insumos', 'Solicitud de insumos específicos para el desarrollo de actividades dentro del Colegio de Ingenieros del Perú.', '2025-02-17 22:31:49', NULL, NULL, 1),
(21, 'Otro', 'Otro', '2025-02-17 22:31:49', NULL, NULL, 1),
(22, 'Hola 8', 'Tramite prueba XD', '2025-02-17 22:56:57', '2025-02-17 22:58:18', '2025-02-17 22:58:37', 0),
(23, 'Hola 1', 'edededeedde', '2025-02-17 22:58:48', '2025-02-17 22:59:07', '2025-02-17 22:59:13', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE `tm_usuario` (
  `user_id` int(10) NOT NULL,
  `usu_nomape` varchar(90) NOT NULL,
  `usu_correo` varchar(50) NOT NULL,
  `usu_pass` varchar(200) DEFAULT NULL,
  `fech_crea` datetime NOT NULL DEFAULT current_timestamp(),
  `usu_img` varchar(500) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `fech_acti` datetime DEFAULT NULL,
  `est` int(10) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`user_id`, `usu_nomape`, `usu_correo`, `usu_pass`, `fech_crea`, `usu_img`, `rol_id`, `fech_modi`, `fech_elim`, `fech_acti`, `est`) VALUES
(39, 'prueba', 'prueba@gmail.com', 'kKDynpCO1BS6vWHdf5diHbAIH4Dxic1IKMbeTxjDAR0=', '2024-11-10 01:32:40', NULL, NULL, NULL, NULL, NULL, 2),
(40, 'prueba2', 'prueba2@gmail.com', '12345678', '2024-11-10 01:34:40', NULL, NULL, NULL, NULL, NULL, 2),
(41, 'prueba3', 'prueba4@gmail.com', '12345678', '2024-11-10 01:39:40', NULL, NULL, NULL, NULL, NULL, 2),
(42, 'prueba3', 'prueba5@gmail.com', '987654321', '2024-11-10 01:39:54', NULL, NULL, NULL, NULL, NULL, 2),
(43, 'prueba7', 'prueba7@gmail.com', '12345678', '2024-11-10 01:43:05', NULL, NULL, NULL, NULL, NULL, 2),
(44, 'prueba3', 'prueba8@gmail.com', '12345678', '2024-11-10 01:48:45', NULL, NULL, NULL, NULL, NULL, 2),
(45, 'prueba9', 'prueba9@gmail.com', '12345678', '2024-11-10 02:15:27', NULL, NULL, NULL, NULL, NULL, 2),
(46, 'prueba10', 'prueba10@gmail.com', '12345678', '2024-11-10 02:16:24', NULL, NULL, NULL, NULL, NULL, 2),
(47, 'prueba15', 'prueba15@gmail.com', '12345678', '2024-11-11 21:12:34', NULL, NULL, NULL, NULL, NULL, 2),
(48, 'prueba16', 'prueba16@gmail.com', '12345678', '2024-11-11 21:15:19', NULL, NULL, NULL, NULL, '2024-11-27 00:35:45', 1),
(49, 'prueba11', 'prueba11@gmail.com', '12345678', '2024-11-11 21:21:52', NULL, NULL, NULL, NULL, NULL, 2),
(50, 'prueba12', 'prueba12@gmail.com', '12345678', '2024-11-19 23:40:00', NULL, NULL, NULL, NULL, '2024-11-27 00:32:55', 1),
(63, 'prueba20', 'u19309934@utp.edu.pe', '12345678', '2024-11-27 01:19:12', NULL, NULL, NULL, NULL, NULL, 2),
(67, 'prueba78', 'prueba78@gmail.com', 'Q1ehaxPLJqx2c5tQRLVK6Uw6xpg6abWgW6uufMD6irc=', '2025-01-02 21:00:12', NULL, NULL, NULL, NULL, NULL, 2),
(87, 'Groupsy', 'groupsy777@gmail.com', 'Hdh0ZSFBh0PxEfrtBhiRR1ngMopHItqnaQw4Dyn5Dd0=', '2025-01-16 23:58:16', 'https://lh3.googleusercontent.com/a/ACg8ocJPe5klMxSja5_GXW6Xe-vpi1zUUt9rSGLGsdkvyLJbw_kjfQ=s96-c', NULL, NULL, NULL, NULL, 1),
(88, 'Carlos Efra', 'prueba7777@gmail.com', 'lbOVzlHaJGybAfogB7gAHclUV/HDvHI0+7kTQX73vSg=', '2025-02-09 16:58:07', '', 2, NULL, NULL, NULL, 2),
(101, 'Edita Chafloque', 'echafloquecajusol@gmail.com', 'zL47+NpEe2k6yH07qQmoyHSxpr9gKUoQ52UMCTgzsA4=', '2025-02-10 22:04:09', '', 1, NULL, NULL, NULL, 2),
(102, 'Edita Cajusol', 'u20234626@utp.edu.pe', 'UQgStk/wNei0NNXdamOciH86OBIbF+ON17HXOSdh4Sg=', '2025-02-10 22:09:29', '', 1, NULL, NULL, NULL, 2),
(103, 'Jose Carlos Guzman Perez', 'guzmanperezjosecarlos33@gmail.com', '1sZplGvNDleeeQMAF0v6cjPMqhoe1xwNZ1DmIl5vXMY=', '2025-02-12 00:35:55', 'https://lh3.googleusercontent.com/a/ACg8ocKH3ZMrm2oG3vVbdQXyGg9ErisudMgfCW4r1fUkYTka8rESrg=s96-c', 1, NULL, NULL, NULL, 1),
(104, 'Carlos Efrain Chafloque Lllontop', 'carlosefrainchallo1@gmail.com', 'fJJYQHNZ4qTpVPyqBPobc/XTYa/CMKA/eOemqf+kL7s=', '2025-02-12 00:36:46', 'https://lh3.googleusercontent.com/a/ACg8ocIXAPS7fPlVdIejcDjDfBgg1Wc25rIzUtXy_IQvjXRFaXYSIL30=s96-c', 2, NULL, NULL, NULL, 1),
(105, 'Carlos Efrain Chafloque Llontop', 'seleccionchiclayo@dino.com.pe', 'v1N2xjIW8zI28KN/KyEX1Ip+k3NiBo7DMXWI29rLT1g=', '2025-02-12 00:37:35', 'https://lh3.googleusercontent.com/a/ACg8ocKd_Zky6TYjMc-8UNJJPMOBcdcA9F4vOCer41nDneuE1PDbhltl=s96-c', 3, NULL, NULL, NULL, 1),
(107, 'test', 'test@gmail.com', NULL, '2025-02-17 23:25:57', '../../assets/picture/avatar.png', 2, NULL, NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  ADD PRIMARY KEY (`det_id`);

--
-- Indices de la tabla `tm_area`
--
ALTER TABLE `tm_area`
  ADD PRIMARY KEY (`area_id`);

--
-- Indices de la tabla `tm_documento`
--
ALTER TABLE `tm_documento`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indices de la tabla `tm_rol`
--
ALTER TABLE `tm_rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `tm_tipo`
--
ALTER TABLE `tm_tipo`
  ADD PRIMARY KEY (`tip_id`);

--
-- Indices de la tabla `tm_tramite`
--
ALTER TABLE `tm_tramite`
  ADD PRIMARY KEY (`tra_id`);

--
-- Indices de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  MODIFY `det_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `tm_area`
--
ALTER TABLE `tm_area`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tm_documento`
--
ALTER TABLE `tm_documento`
  MODIFY `doc_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `tm_rol`
--
ALTER TABLE `tm_rol`
  MODIFY `rol_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tm_tipo`
--
ALTER TABLE `tm_tipo`
  MODIFY `tip_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tm_tramite`
--
ALTER TABLE `tm_tramite`
  MODIFY `tra_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
