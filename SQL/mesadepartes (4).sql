-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3305
-- Tiempo de generación: 03-03-2025 a las 02:37:43
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_i_area_01` (IN `xuser_id` INT)   BEGIN
    DECLARE areaCount INT;

    -- Obtener la cantidad de áreas del usuario
    SELECT COUNT(*) INTO areaCount 
    FROM td_area_detalle 
    WHERE user_id = xuser_id;

    -- Si no tiene áreas registradas, insertar todas las activas
    IF areaCount = 0 THEN 
        INSERT INTO td_area_detalle (user_id, area_id)
        SELECT xuser_id, area_id 
        FROM tm_area 
        WHERE est = 1;
    ELSE
        -- Insertar solo las áreas que aún no tenga registradas
        INSERT INTO td_area_detalle (user_id, area_id)
        SELECT xuser_id, area_id 
        FROM tm_area 
        WHERE est = 1 
        AND area_id NOT IN (
            SELECT area_id FROM td_area_detalle WHERE user_id = xuser_id
        );
    END IF;
    
    SELECT 
td_area_detalle.aread_id, td_area_detalle.area_id,td_area_detalle.aread_permi,
tm_area.area_nom,
tm_area.area_correo
    FROM td_area_detalle
    INNER JOIN tm_area ON tm_area.area_id=td_area_detalle.area_id
    WHERE
    td_area_detalle.user_id=xuser_id
    AND tm_area.est=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_i_rol_01` (IN `xrol_id` INT)   BEGIN
	DECLARE rolCount INT;

	SELECT COUNT(*) INTO rolCount FROM td_menu_detalle WHERE rol_id = xrol_id;
	
	IF rolCount = 0 THEN
		INSERT INTO td_menu_detalle(rol_id,men_id)
		SELECT xrol_id,men_id FROM tm_menu WHERE est=1;
	ELSE
		INSERT INTO td_menu_detalle(rol_id,men_id)
		SELECT xrol_id,men_id FROM tm_menu WHERE est=1 AND men_id NOT IN (SELECT men_id FROM td_menu_detalle WHERE rol_id = xrol_id);
	END IF;
	
	SELECT 
		td_menu_detalle.mend_id,
		td_menu_detalle.rol_id,
		td_menu_detalle.mend_permi,
		tm_menu.men_id,
		tm_menu.men_nom,
		tm_menu.men_nom_vista,
		tm_menu.men_icon,
		tm_menu.men_ruta
	FROM td_menu_detalle
	INNER JOIN tm_menu ON tm_menu.men_id = td_menu_detalle.men_id
	WHERE 
	td_menu_detalle.rol_id = xrol_id
	AND tm_menu.est=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_documento_01` (IN `xdoc_id` INT)   BEGIN
SELECT tm_documento.doc_id,tm_documento.area_id, tm_area.area_nom, tm_area.area_correo,tm_documento.doc_externo,tm_documento.doc_dni,tm_documento.doc_nom,tm_documento.doc_descrip,tm_documento.tra_id,tm_tramite.tra_nom,tm_documento.tip_id,tm_tipo.tip_nom,tm_documento.user_id,tm_usuario.usu_nomape,tm_usuario.usu_correo,tm_documento.doc_estado,tm_documento.doc_respuesta,COALESCE(contador.cant,0)as cant, 
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
        tm_documento.doc_estado,
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
-- Estructura de tabla para la tabla `td_area_detalle`
--

CREATE TABLE `td_area_detalle` (
  `aread_id` int(10) NOT NULL,
  `user_id` int(10) DEFAULT NULL,
  `area_id` int(10) DEFAULT NULL,
  `aread_permi` varchar(2) DEFAULT 'No',
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_area_detalle`
--

INSERT INTO `td_area_detalle` (`aread_id`, `user_id`, `area_id`, `aread_permi`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(16, 105, 1, 'Si', '2025-02-22 13:26:34', '2025-02-22 19:13:43', NULL, 1),
(17, 105, 2, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(18, 105, 3, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(19, 105, 4, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(20, 105, 5, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(21, 105, 6, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(22, 105, 7, 'Si', '2025-02-22 13:26:34', '2025-03-02 13:47:09', NULL, 1),
(23, 105, 8, 'Si', '2025-02-22 13:26:34', '2025-03-02 16:53:38', NULL, 1),
(24, 105, 9, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(25, 105, 10, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(26, 105, 12, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(27, 105, 13, 'No', '2025-02-22 13:26:34', NULL, NULL, 1),
(31, 105, 15, 'No', '2025-02-22 13:54:08', NULL, NULL, 1),
(32, 118, 1, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(33, 118, 2, 'No', '2025-02-22 18:04:16', '2025-02-22 19:22:46', NULL, 1),
(34, 118, 3, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(35, 118, 4, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(36, 118, 5, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(37, 118, 6, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(38, 118, 7, 'No', '2025-02-22 18:04:16', '2025-02-22 19:22:52', NULL, 1),
(39, 118, 8, 'No', '2025-02-22 18:04:16', '2025-02-22 19:22:49', NULL, 1),
(40, 118, 9, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(41, 118, 10, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(42, 118, 12, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(43, 118, 13, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(44, 118, 15, 'No', '2025-02-22 18:04:16', NULL, NULL, 1),
(47, 104, 1, 'Si', '2025-02-22 19:24:12', '2025-02-27 23:12:08', NULL, 1),
(48, 104, 2, 'No', '2025-02-22 19:24:12', '2025-02-27 23:12:07', NULL, 1),
(49, 104, 3, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(50, 104, 4, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(51, 104, 5, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(52, 104, 6, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(53, 104, 7, 'Si', '2025-02-22 19:24:12', '2025-02-27 23:12:10', NULL, 1),
(54, 104, 8, 'Si', '2025-02-22 19:24:12', '2025-02-27 23:12:06', NULL, 1),
(55, 104, 9, 'No', '2025-02-22 19:24:12', '2025-03-01 18:04:06', NULL, 1),
(56, 104, 10, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(57, 104, 12, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(58, 104, 13, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(59, 104, 15, 'No', '2025-02-22 19:24:12', NULL, NULL, 1),
(62, 116, 1, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(63, 116, 2, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(64, 116, 3, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(65, 116, 4, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(66, 116, 5, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(67, 116, 6, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(68, 116, 7, 'Si', '2025-02-22 19:24:31', '2025-02-22 19:24:34', NULL, 1),
(69, 116, 8, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(70, 116, 9, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(71, 116, 10, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(72, 116, 12, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(73, 116, 13, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(74, 116, 15, 'No', '2025-02-22 19:24:31', NULL, NULL, 1),
(75, 111, 1, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(76, 111, 2, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(77, 111, 3, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(78, 111, 4, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(79, 111, 5, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(80, 111, 6, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(81, 111, 7, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(82, 111, 8, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(83, 111, 9, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(84, 111, 10, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(85, 111, 12, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(86, 111, 13, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(87, 111, 15, 'No', '2025-03-01 18:04:27', NULL, NULL, 1),
(88, 120, 1, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(89, 120, 2, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(90, 120, 3, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(91, 120, 4, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(92, 120, 5, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(93, 120, 6, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(94, 120, 7, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(95, 120, 8, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(96, 120, 9, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(97, 120, 10, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(98, 120, 12, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(99, 120, 13, 'No', '2025-03-02 17:07:39', NULL, NULL, 1),
(100, 120, 15, 'No', '2025-03-02 17:07:39', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento_detalle`
--

CREATE TABLE `td_documento_detalle` (
  `det_id` int(10) NOT NULL,
  `doc_id` int(10) DEFAULT NULL,
  `det_nom` varchar(250) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `det_tipo` varchar(50) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_documento_detalle`
--

INSERT INTO `td_documento_detalle` (`det_id`, `doc_id`, `det_nom`, `user_id`, `det_tipo`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 1, 'test.php', 1, 'Pendiente', NULL, NULL, NULL, 1),
(2, 8, 'C:\\xampp\\tmp\\php3578.tmp', 71, 'Pendiente', NULL, NULL, NULL, 1),
(3, 9, 'C:\\xampp\\tmp\\php458E.tmp', 71, 'Pendiente', NULL, NULL, NULL, 1),
(4, 9, 'C:\\xampp\\tmp\\php459F.tmp', 71, 'Pendiente', NULL, NULL, NULL, 1),
(5, 10, '1. Ficha de Datos.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(6, 10, '1. Checklist Documentos.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(7, 10, '3. Documentos a completar.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(8, 10, 'Carta de Presentación D.I.N.O S.R.L.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(9, 11, 'HABLEMOS DE SEGURIDAD, SALUD Y MEDIO AMBIENTE - FEBRERO 2025.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(10, 12, 'DJ.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(11, 13, '16. DJ HERRERA PAREDES ALMILCAR MICHEL.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(12, 14, '8aa96068-034a-469b-89ab-6c11564d1303.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(13, 14, 'GC_I46N_TF_21C1.pdf', 71, 'Pendiente', NULL, NULL, NULL, 1),
(14, 15, 'Proyecto de Investigación pre final.docx.pdf', 71, 'Pendiente', '2025-02-02 19:35:48', NULL, NULL, 1),
(15, 15, 'Certificado ACI 2020 -2021MIGUEL ESPINOZA.pdf', 71, 'Pendiente', '2025-02-02 19:35:48', NULL, NULL, 1),
(16, 16, '104b97d5-f3aa-4c5c-a345-799af415d6f2.pdf', 71, 'Pendiente', '2025-02-02 19:39:06', NULL, NULL, 1),
(17, 16, 'Anexo 6.pdf', 71, 'Pendiente', '2025-02-02 19:39:06', NULL, NULL, 1),
(18, 17, '16. DJ HERRERA PAREDES ALMILCAR MICHEL.pdf', 71, 'Pendiente', '2025-02-02 21:51:16', NULL, NULL, 1),
(19, 18, 'CARGO DE ENTREGA _RISSO.pdf', 71, 'Pendiente', '2025-02-02 22:01:01', NULL, NULL, 1),
(20, 19, 'HABLEMOS DE SEGURIDAD, SALUD Y MEDIO AMBIENTE - FEBRERO 2025.pdf', 71, 'Pendiente', '2025-02-04 22:32:06', NULL, NULL, 1),
(21, 19, 'DJ.pdf', 71, 'Pendiente', '2025-02-04 22:32:06', NULL, NULL, 1),
(22, 20, 'DJ.pdf', 71, 'Pendiente', '2025-02-04 23:02:23', NULL, NULL, 1),
(23, 20, 'RIT.pdf', 71, 'Pendiente', '2025-02-04 23:02:23', NULL, NULL, 1),
(24, 20, 'CARGO DE ENTREGA _RISSO.pdf', 71, 'Pendiente', '2025-02-04 23:02:23', NULL, NULL, 1),
(25, 21, 'CARGO DE ENTREGA _RISSO.pdf', 71, 'Pendiente', '2025-02-04 23:07:44', NULL, NULL, 1),
(26, 21, '21. CARGO DE ENTREGA REGLAMENTO INTERNO DE TRABAJO.pdf', 71, 'Pendiente', '2025-02-04 23:07:44', NULL, NULL, 1),
(27, 22, 'ficha, firma y huella20240908_23055471.pdf', 71, 'Pendiente', '2025-02-04 23:12:07', NULL, NULL, 1),
(28, 22, 'firma y huella.pdf', 71, 'Pendiente', '2025-02-04 23:12:07', NULL, NULL, 1),
(29, 23, 'Padre_rico_Padre_pobre_Nueva_edición_actualizada_Qué_les_enseñan.pdf', 71, 'Pendiente', '2025-02-04 23:13:13', NULL, NULL, 1),
(30, 24, 'DJ.pdf', 71, 'Pendiente', '2025-02-04 23:38:52', NULL, NULL, 1),
(31, 24, 'RIT.pdf', 71, 'Pendiente', '2025-02-04 23:38:52', NULL, NULL, 1),
(32, 24, 'CARGO DE ENTREGA _RISSO.pdf', 71, 'Pendiente', '2025-02-04 23:38:52', NULL, NULL, 1),
(33, 24, '21. CARGO DE ENTREGA REGLAMENTO INTERNO DE TRABAJO.pdf', 71, 'Pendiente', '2025-02-04 23:38:52', NULL, NULL, 1),
(34, 24, '21. CARGO DE ENTREGA REGLAMENTO INTERNO DE TRABAJO (5).pdf', 71, 'Pendiente', '2025-02-04 23:38:52', NULL, NULL, 1),
(35, 25, 'RIT.pdf', 71, 'Pendiente', '2025-02-04 23:50:23', NULL, NULL, 1),
(36, 26, 'DJ.pdf', 71, 'Pendiente', '2025-02-07 21:53:43', NULL, NULL, 1),
(37, 26, 'RIT.pdf', 71, 'Pendiente', '2025-02-07 21:53:43', NULL, NULL, 1),
(38, 27, 'Declaracion_juradada_documentos_bachiller (1).pdf', 71, 'Pendiente', '2025-02-08 13:53:07', NULL, NULL, 1),
(39, 28, 'Proyecto de Investigación final.docx.pdf', 71, 'Pendiente', '2025-02-08 14:21:04', NULL, NULL, 1),
(40, 28, 'CIR_ALT_PFL_20131644524_48855575_1309202421185.pdf', 71, 'Pendiente', '2025-02-08 14:21:04', NULL, NULL, 1),
(41, 29, 'Programa de Futuros Empresarios.pdf', 82, 'Pendiente', '2025-02-08 14:26:12', NULL, NULL, 1),
(42, 29, 'Certificados Operadores Bomba de Concreto - CEMENTOS PACASMAYO (1).pdf', 82, 'Pendiente', '2025-02-08 14:26:12', NULL, NULL, 1),
(43, 30, 'EMO_CHAFLOQUE_LLONTOP__443633_88_removed.pdf', 71, 'Pendiente', '2025-02-09 16:21:44', NULL, NULL, 1),
(44, 30, 'CAMO_CHAFLOQUE_LLONTOP_443633_81.PDF', 71, 'Pendiente', '2025-02-09 16:21:44', NULL, NULL, 1),
(45, 31, 'CARGO DE ENTREGA _RISSO.pdf', 100, 'Pendiente', '2025-02-09 21:22:43', NULL, NULL, 1),
(46, 32, 'RIT.pdf', 96, 'Pendiente', '2025-02-10 21:22:04', NULL, NULL, 1),
(47, 32, 'CARGO DE ENTREGA _RISSO.pdf', 96, 'Pendiente', '2025-02-10 21:22:04', NULL, NULL, 1),
(48, 33, 'cv con constancias de practicas_removed.pdf', 96, 'Pendiente', '2025-02-10 21:32:04', NULL, NULL, 1),
(49, 33, 'S10-s01 RAID.pdf', 96, 'Pendiente', '2025-02-10 21:32:04', NULL, NULL, 1),
(50, 34, '104b97d5-f3aa-4c5c-a345-799af415d6f2.pdf', 96, 'Pendiente', '2025-02-10 21:59:55', NULL, NULL, 1),
(51, 35, 'Certificado ACI 2020 -2021 JIMMY PEREZ.pdf', 96, 'Pendiente', '2025-02-10 22:01:45', NULL, NULL, 1),
(52, 37, 'S11-s01 SAN (1).pdf', 101, 'Pendiente', '2025-02-10 22:06:34', NULL, NULL, 1),
(53, 38, 'applicant_1054524242_CV_1047880253.pdf', 103, 'Pendiente', '2025-02-12 02:05:47', NULL, NULL, 1),
(54, 39, 'CAMO_CHAFLOQUE_LLONTOP_443633_81.PDF', 103, 'Pendiente', '2025-02-16 19:57:36', NULL, NULL, 1),
(55, 40, 'Certificado ACI 2020 -2021MIGUEL ESPINOZA.pdf', 103, 'Pendiente', '2025-02-21 01:20:35', NULL, NULL, 1),
(56, 41, 'matrícula Santiago.pdf', 103, 'Pendiente', '2025-02-22 19:25:43', NULL, NULL, 1),
(57, 42, 'RIT.pdf', 121, 'Pendiente', '2025-02-26 02:40:29', NULL, NULL, 1),
(58, 43, 'Anexo 6.pdf', 121, 'Pendiente', '2025-02-27 23:43:39', NULL, NULL, 1),
(59, 43, 'Anexo 5.pdf', 121, 'Pendiente', '2025-02-27 23:43:39', NULL, NULL, 1),
(60, 44, 'Anexo 6.pdf', 121, 'Pendiente', '2025-03-01 17:56:10', NULL, NULL, 1),
(61, 44, 'Anexo 5.pdf', 121, 'Pendiente', '2025-03-01 17:56:10', NULL, NULL, 1),
(62, 42, 'respuesta1.pdf', 105, 'Terminado', '2025-03-02 16:39:39', NULL, NULL, 1),
(63, 42, 'respuesta2.pdf', 105, 'Terminado', '2025-03-02 16:39:39', NULL, NULL, 1),
(64, 42, 'respuesta3.pdf', 105, 'Terminado', '2025-03-02 16:39:39', NULL, NULL, 1),
(65, 45, '3. Documentos a completar.pdf', 121, 'Pendiente', '2025-03-02 16:42:00', NULL, NULL, 1),
(66, 45, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 16:43:31', NULL, NULL, 1),
(67, 46, 'anexo 7 firma.pdf', 121, 'Pendiente', '2025-03-02 16:52:21', NULL, NULL, 1),
(68, 46, 'respuesta1.pdf', 105, 'Terminado', '2025-03-02 16:54:18', NULL, NULL, 1),
(69, 44, 'respuesta1.pdf', 105, 'Terminado', '2025-03-02 16:58:12', NULL, NULL, 1),
(70, 44, 'respuesta2.pdf', 105, 'Terminado', '2025-03-02 16:58:12', NULL, NULL, 1),
(71, 44, 'respuesta3.pdf', 105, 'Terminado', '2025-03-02 16:58:12', NULL, NULL, 1),
(72, 47, 'S11-s01 SAN.pdf', 124, 'Pendiente', '2025-03-02 17:12:05', NULL, NULL, 1),
(73, 47, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 17:13:31', NULL, NULL, 1),
(74, 48, 'CONSIDERACIONES HDS.pdf', 124, 'Pendiente', '2025-03-02 17:38:18', NULL, NULL, 1),
(75, 49, 'S06_s1 - Certificación Internacional del profesional (1).pdf', 124, 'Pendiente', '2025-03-02 17:39:01', NULL, NULL, 1),
(76, 50, 'S06_s2 - Certificaciones ISACA (1).pdf', 124, 'Pendiente', '2025-03-02 17:39:45', NULL, NULL, 1),
(77, 51, 'S12_s1- Principios Cobit.pdf', 124, 'Pendiente', '2025-03-02 17:40:40', NULL, NULL, 1),
(78, 52, 'S09_s2 - Controles internos 2.pdf', 124, 'Pendiente', '2025-03-02 17:41:51', NULL, NULL, 1),
(79, 52, 'Avance 3 - Gobierno de TI.pdf', 124, 'Pendiente', '2025-03-02 17:41:51', NULL, NULL, 1),
(80, 53, '8cf06a92-28bd-4a0c-873d-5ff6e8d1a78d.pdf', 124, 'Pendiente', '2025-03-02 17:42:24', NULL, NULL, 1),
(81, 48, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 17:43:38', NULL, NULL, 1),
(82, 52, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 17:44:12', NULL, NULL, 1),
(83, 52, 'respuesta2.pdf', 104, 'Terminado', '2025-03-02 17:44:12', NULL, NULL, 1),
(84, 50, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 17:44:43', NULL, NULL, 1),
(85, 51, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 18:00:34', NULL, NULL, 1),
(86, 54, 'c1accaba-b753-4749-8af6-c63a33802582.pdf', 121, 'Pendiente', '2025-03-02 18:01:40', NULL, NULL, 1),
(87, 54, 'b60eb5ea-1f31-4c38-b10a-b39a0e612de1.pdf', 121, 'Pendiente', '2025-03-02 18:01:40', NULL, NULL, 1),
(88, 55, 'S10-s01 RAID.pdf', 121, 'Pendiente', '2025-03-02 18:02:38', NULL, NULL, 1),
(89, 55, 'S13-s01 Telefonia_IP_Simulación.pdf', 121, 'Pendiente', '2025-03-02 18:02:38', NULL, NULL, 1),
(90, 55, 'S12-s02 Telefonia_IP_Simulación.pdf', 121, 'Pendiente', '2025-03-02 18:02:38', NULL, NULL, 1),
(91, 55, 'S12-s01 Telefonia_IP (1).pdf', 121, 'Pendiente', '2025-03-02 18:02:38', NULL, NULL, 1),
(92, 54, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 18:04:00', NULL, NULL, 1),
(93, 54, 'respuesta2.pdf', 104, 'Terminado', '2025-03-02 18:04:00', NULL, NULL, 1),
(94, 55, 'respuesta1.pdf', 104, 'Terminado', '2025-03-02 18:06:38', NULL, NULL, 1),
(95, 55, 'respuesta2.pdf', 104, 'Terminado', '2025-03-02 18:06:38', NULL, NULL, 1),
(96, 55, 'respuesta3.pdf', 104, 'Terminado', '2025-03-02 18:06:38', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_menu_detalle`
--

CREATE TABLE `td_menu_detalle` (
  `mend_id` int(10) NOT NULL,
  `rol_id` int(10) DEFAULT NULL,
  `men_id` int(10) DEFAULT NULL,
  `mend_permi` varchar(2) DEFAULT 'No',
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_menu_detalle`
--

INSERT INTO `td_menu_detalle` (`mend_id`, `rol_id`, `men_id`, `mend_permi`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 3, 1, 'No', '2025-02-23 02:29:08', '2025-02-26 00:05:23', NULL, 1),
(2, 3, 2, 'No', '2025-02-23 02:29:08', '2025-02-26 00:28:37', NULL, 1),
(3, 3, 3, 'No', '2025-02-23 02:29:08', '2025-02-26 00:05:21', NULL, 1),
(4, 3, 4, 'Si', '2025-02-23 02:29:08', '2025-02-26 01:29:27', NULL, 1),
(5, 3, 5, 'Si', '2025-02-23 02:29:08', '2025-03-01 18:40:29', NULL, 1),
(6, 3, 6, 'No', '2025-02-23 02:29:08', '2025-02-26 00:05:21', NULL, 1),
(7, 3, 7, 'Si', '2025-02-23 02:29:08', '2025-02-26 00:55:27', NULL, 1),
(8, 3, 8, 'Si', '2025-02-23 02:29:08', '2025-02-26 01:03:19', NULL, 1),
(9, 3, 9, 'Si', '2025-02-23 02:29:08', '2025-02-23 04:32:03', NULL, 1),
(10, 3, 10, 'Si', '2025-02-23 02:29:08', '2025-02-23 04:32:02', NULL, 1),
(11, 3, 11, 'Si', '2025-02-23 02:29:08', '2025-02-23 04:32:02', NULL, 1),
(27, 1, 1, 'Si', '2025-02-26 00:09:34', '2025-02-26 00:09:49', NULL, 1),
(28, 1, 2, 'Si', '2025-02-26 00:09:34', '2025-02-26 00:09:50', NULL, 1),
(29, 1, 3, 'Si', '2025-02-26 00:09:34', '2025-02-26 00:09:36', NULL, 1),
(30, 1, 4, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(31, 1, 5, 'No', '2025-02-26 00:09:34', '2025-02-26 01:10:57', NULL, 1),
(32, 1, 6, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(33, 1, 7, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(34, 1, 8, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(35, 1, 9, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(36, 1, 10, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(37, 1, 11, 'No', '2025-02-26 00:09:34', NULL, NULL, 1),
(42, 2, 1, 'No', '2025-02-26 00:53:17', NULL, NULL, 1),
(43, 2, 2, 'No', '2025-02-26 00:53:17', NULL, NULL, 1),
(44, 2, 3, 'No', '2025-02-26 00:53:17', '2025-02-26 01:03:52', NULL, 1),
(45, 2, 4, 'Si', '2025-02-26 00:53:17', '2025-02-26 01:03:58', NULL, 1),
(46, 2, 5, 'Si', '2025-02-26 00:53:17', '2025-02-26 01:04:03', NULL, 1),
(47, 2, 6, 'Si', '2025-02-26 00:53:17', '2025-02-26 01:04:06', NULL, 1),
(48, 2, 7, 'No', '2025-02-26 00:53:17', '2025-02-26 00:53:28', NULL, 1),
(49, 2, 8, 'No', '2025-02-26 00:53:17', NULL, NULL, 1),
(50, 2, 9, 'No', '2025-02-26 00:53:17', NULL, NULL, 1),
(51, 2, 10, 'No', '2025-02-26 00:53:17', NULL, NULL, 1),
(52, 2, 11, 'No', '2025-02-26 00:53:17', NULL, NULL, 1);

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
(9, 'Logistica', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', '2025-03-02 12:55:01', NULL, 1),
(10, 'Legal y Cumplimiento', 'Carloschallo1@hotmail.com', '2025-02-04 22:59:52', NULL, NULL, 1),
(12, 'XD98', 'xd98@gmail.com', '2025-02-16 18:56:14', '2025-02-16 19:35:15', '2025-02-16 19:16:11', 1),
(13, 'tipo18', 'tipo12@gmail.com', '2025-02-16 19:37:32', '2025-02-16 19:52:33', '2025-02-16 19:38:37', 1),
(14, 'tipo21', 'tipocuaq@gmail.com', '2025-02-16 19:52:55', '2025-02-16 19:53:15', '2025-02-16 19:53:27', 0),
(15, 'nueva area', 'areanueva@gmail.com', '2025-02-22 13:53:50', NULL, NULL, 1);

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
  `doc_estado` varchar(50) NOT NULL DEFAULT 'Pendiente',
  `doc_respuesta` varchar(500) DEFAULT NULL,
  `doc_usu_terminado` int(11) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `fech_terminado` datetime DEFAULT NULL,
  `est` int(10) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_documento`
--

INSERT INTO `tm_documento` (`doc_id`, `area_id`, `tra_id`, `doc_externo`, `tip_id`, `doc_dni`, `doc_nom`, `doc_descrip`, `user_id`, `doc_estado`, `doc_respuesta`, `doc_usu_terminado`, `fech_crea`, `fech_modi`, `fech_elim`, `fech_terminado`, `est`) VALUES
(1, 1, 1, 'TEST', 1, '123456', 'TEST NOMBRE', 'BLA BLA', 1, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(2, 2, 6, 'abcd', 1, 'deeded', 'eddeed', 'wsswsw', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(3, 2, 2, 'abcd', 1, 'deeded', '', 'hyyhhy', 85, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(4, 2, 1, 'abcd', 1, 'deeded', 'eddeed', 'Hola papu', 85, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(5, 2, 1, 'abcd', 2, 'deeded', 'eddeed', 'ujuju', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(6, 2, 1, 'abcd', 2, 'abc', 'dd', 'deedde', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(7, 1, 5, '123de', 1, '123abc', 'eddeed', 'eded', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(8, 2, 1, 'abcd', 1, '777', '777', 'iikki', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(9, 2, 1, '777', 1, '777', '777', 'Suerte', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(10, 2, 1, '777', 2, '123abc', '777', 'Suerte suerte', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(11, 2, 1, '777', 1, 'deeded', 'eddeed', 'ijiji', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(12, 0, 0, '', 2, '777', '777', 'ikik', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(13, 2, 2, '777', 1, '777', '777', 'iubiu', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(14, 7, 2, '777', 1, '777', '777', 'Hola', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(15, 8, 2, '777', 1, 'deeded', 'eddeed', 'fecha', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(16, 2, 2, '777', 2, '777', '777', 'fecha', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(17, 2, 2, 'abcd', 1, 'deeded', 'eddeed', 'trtrt', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(18, 2, 1, '777', 1, '777', '777', '777 suerte', 71, 'Pendiente', NULL, NULL, '2025-02-04 21:50:05', NULL, NULL, '0000-00-00 00:00:00', 1),
(19, 2, 2, '777', 1, '777', '777', 'Prueba 777, exitos.', 71, 'Pendiente', NULL, NULL, '2025-02-04 22:32:03', NULL, NULL, '0000-00-00 00:00:00', 1),
(20, 1, 13, '777', 2, '777', '777', 'Hola777', 71, 'Pendiente', NULL, NULL, '2025-02-04 23:02:20', NULL, NULL, '0000-00-00 00:00:00', 1),
(21, 1, 2, '777', 1, '777', 'eddeed', 'wswwssw', 71, 'Pendiente', NULL, NULL, '2025-02-04 23:07:44', NULL, NULL, '0000-00-00 00:00:00', 1),
(22, 2, 1, '777', 1, '777', '777', 'Hola no hay plata', 71, 'Pendiente', NULL, NULL, '2025-02-04 23:12:07', NULL, NULL, '0000-00-00 00:00:00', 1),
(23, 8, 2, '777', 1, '777', 'eddeed', 'jonoi', 71, 'Pendiente', NULL, NULL, '2025-02-04 23:13:13', NULL, NULL, '0000-00-00 00:00:00', 1),
(24, 8, 1, '777', 1, '777', '777', 'tggt', 71, 'Pendiente', NULL, NULL, '2025-02-04 23:38:52', NULL, NULL, '0000-00-00 00:00:00', 1),
(25, 8, 2, '777', 1, '777', '777', 'yy', 71, 'Pendiente', NULL, NULL, '2025-02-04 23:50:23', NULL, NULL, '0000-00-00 00:00:00', 1),
(26, 2, 2, '777', 1, '777', '777', 'Hola Efrain eres lo máximo.', 71, 'Pendiente', NULL, NULL, '2025-02-07 21:53:43', NULL, NULL, '0000-00-00 00:00:00', 1),
(27, 7, 1, '777', 1, '81859635', 'Postulación', 'Hola, soy Efrain.', 71, 'Pendiente', NULL, NULL, '2025-02-08 13:53:07', NULL, NULL, '0000-00-00 00:00:00', 1),
(28, 8, 1, 'abcd', 1, '777', 'ededde', 'deeded', 71, 'Pendiente', NULL, NULL, '2025-02-08 14:21:04', NULL, NULL, '0000-00-00 00:00:00', 1),
(29, 1, 18, '787', 2, '897', 'Vacaciones Trujillo', 'Vacaciones con mi familia.', 82, 'Pendiente', NULL, NULL, '2025-02-08 14:26:12', NULL, NULL, '0000-00-00 00:00:00', 1),
(30, 7, 1, '184', 1, '84858689', 'Efra', 'Hola, soy Efra.', 71, 'Pendiente', NULL, NULL, '2025-02-09 16:21:44', NULL, NULL, '0000-00-00 00:00:00', 1),
(31, 2, 1, '897', 1, '897', 'eddeed', 'eddedede', 100, 'Pendiente', NULL, NULL, '2025-02-09 21:22:43', NULL, NULL, '0000-00-00 00:00:00', 1),
(32, 2, 2, '985623', 1, '81859586', 'Edita', 'Hola soy Edita', 96, 'Pendiente', NULL, NULL, '2025-02-10 21:22:04', NULL, NULL, '0000-00-00 00:00:00', 1),
(33, 1, 13, '123de', 2, '89874565', 'eddeed', 'Hola soy Anita la huerfanita.', 96, 'Pendiente', NULL, NULL, '2025-02-10 21:32:04', NULL, NULL, '0000-00-00 00:00:00', 1),
(34, 3, 13, '20285', 1, '85868982', 'Jose Carlos', 'Hola que tal, voy al de Marketing', 96, 'Pendiente', NULL, NULL, '2025-02-10 21:59:55', NULL, NULL, '0000-00-00 00:00:00', 1),
(35, 8, 3, 'ededde', 2, 'deed', 'ededed', 'deeded', 96, 'Pendiente', NULL, NULL, '2025-02-10 22:01:45', NULL, NULL, '0000-00-00 00:00:00', 1),
(36, 8, 3, 'deed', 1, 'deeded', 'eded', 'ededed', 96, 'Pendiente', NULL, NULL, '2025-02-10 22:02:25', NULL, NULL, '0000-00-00 00:00:00', 1),
(37, 10, 2, '8459', 1, '895869', 'Edita', 'Hola, soy Edita.', 101, 'Pendiente', NULL, NULL, '2025-02-10 22:06:34', NULL, NULL, '0000-00-00 00:00:00', 1),
(38, 2, 1, 'eededed', 2, 'deeded', 'ededed', 'edededed', 103, 'Pendiente', NULL, NULL, '2025-02-12 02:05:47', NULL, NULL, '0000-00-00 00:00:00', 1),
(39, 1, 3, '77779', 1, '7777', 'buenasuertepapu', 'Buenasuertepapuprueba seeleccion', 103, 'Pendiente', NULL, NULL, '2025-02-16 19:57:36', NULL, NULL, '0000-00-00 00:00:00', 1),
(40, 1, 1, '8985', 1, '789878', 'Hello word', 'Hola mundo', 103, 'Pendiente', NULL, NULL, '2025-02-21 01:20:35', NULL, NULL, '0000-00-00 00:00:00', 1),
(41, 7, 8, 'abcd', 2, '48488448', 'Jose Peralta', 'Ver si funciona los roles', 103, 'Pendiente', NULL, NULL, '2025-02-22 19:25:43', NULL, NULL, '0000-00-00 00:00:00', 1),
(42, 1, 1, 'ferfr', 1, 'rfrfrf', 'frfrf', 'rffr', 121, 'Terminado', 'Hola le doy respuesta al documento 42', 105, '2025-02-26 02:40:29', NULL, NULL, '2025-03-02 16:39:39', 1),
(43, 7, 17, '123', 2, '89562356', 'Pamela', 'Hola soy Pamela.', 121, 'Terminado', 'Hola le doy respuesta al documento 43', 105, '2025-02-27 23:43:39', NULL, NULL, '2025-03-02 16:30:47', 1),
(44, 1, 4, '868', 1, '89562389', 'Jose Carlos', 'Hola Mundo.', 121, 'Terminado', 'Hola le doy respuesta al documento 44', 105, '2025-03-01 17:56:10', NULL, NULL, '2025-03-02 16:58:12', 1),
(45, 7, 2, '123', 1, '89562356', '777', 'Hola como estas', 121, 'Terminado', 'Hola respuesta al 45', 104, '2025-03-02 16:42:00', NULL, NULL, '2025-03-02 16:43:31', 1),
(46, 8, 2, '777', 2, '78652356', 'Jose Carlos', 'Hola, I+D', 121, 'Terminado', 'Hola, te doy respuesta al documento 46', 105, '2025-03-02 16:52:21', NULL, NULL, '2025-03-02 16:54:18', 1),
(47, 1, 1, '789654', 1, '9874563', 'Eduardo', 'Hola soy Eduardo', 124, 'Terminado', 'Hola Eduardo, te doy respuesta al documento 47.', 104, '2025-03-02 17:12:05', NULL, NULL, '2025-03-02 17:13:31', 1),
(48, 1, 1, '777', 2, '896523', 'Eduardo', 'Hola 1', 124, 'Terminado', 'Hola Eduardo, te doy respuesta al documento 48', 104, '2025-03-02 17:38:18', NULL, NULL, '2025-03-02 17:43:38', 1),
(49, 7, 11, '85235', 2, '9875632', 'Eduardo', 'Envio 2', 124, 'Pendiente', NULL, NULL, '2025-03-02 17:39:01', NULL, NULL, NULL, 1),
(50, 8, 1, 'abcd', 1, '962356', 'Eduardo', 'Hola soy Eduardo', 124, 'Terminado', 'Hola Eduardo te doy respuesta al documento 50.', 104, '2025-03-02 17:39:45', NULL, NULL, '2025-03-02 17:44:43', 1),
(51, 1, 7, '987321654', 1, '9595995', 'Eduardo', 'Evio 2 RRHH', 124, 'Terminado', 'Hola Eduardo, te doy respuesta al tramite N° 51', 104, '2025-03-02 17:40:40', NULL, NULL, '2025-03-02 18:00:34', 1),
(52, 7, 6, '9632145', 1, '89562356', 'Eduardo', 'Envio 2 TI', 124, 'Terminado', 'Hola Eduardo te doy respuesta al documento 52', 104, '2025-03-02 17:41:51', NULL, NULL, '2025-03-02 17:44:12', 1),
(53, 8, 11, '963256', 2, '123abc', 'Eduardo', '89652314789', 124, 'Pendiente', NULL, NULL, '2025-03-02 17:42:24', NULL, NULL, NULL, 1),
(54, 1, 1, '985623', 1, '9632145', 'Jose Guzman', 'Hola estimado', 121, 'Terminado', 'Hola estiamado le doy la respuesta al tramite 54', 104, '2025-03-02 18:01:40', NULL, NULL, '2025-03-02 18:04:00', 1),
(55, 1, 2, '985623', 2, 'deeded', 'Jose Guzman', 'Hola estimado', 121, 'Terminado', 'Hola estimado, le doy respuesta al tramite N° 55', 104, '2025-03-02 18:02:38', NULL, NULL, '2025-03-02 18:06:38', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_menu`
--

CREATE TABLE `tm_menu` (
  `men_id` int(11) NOT NULL,
  `men_nom` varchar(200) DEFAULT NULL,
  `men_nom_vista` varchar(200) DEFAULT NULL,
  `men_icon` varchar(200) DEFAULT NULL,
  `men_ruta` varchar(200) DEFAULT NULL,
  `fech_crea` datetime DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_menu`
--

INSERT INTO `tm_menu` (`men_id`, `men_nom`, `men_nom_vista`, `men_icon`, `men_ruta`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(1, 'home', 'Inicio', 'home', '../home/', '2025-02-23 01:07:45', NULL, NULL, 1),
(2, 'nuevotramite', 'Nuevo Tramite', 'grid', '../NuevoTramite/', '2025-02-23 01:07:45', NULL, NULL, 1),
(3, 'consultartramite', 'Consultar Tramite', 'users', '../ConsultarTramite/', '2025-02-23 01:07:45', NULL, NULL, 1),
(4, 'homecolaborador', 'Inicio Colaborador', 'home', '../homecolaborador/', '2025-02-23 01:07:45', NULL, NULL, 1),
(5, 'gestionartramite', 'Gestionar Tramite', 'grid', '../gestionartramite/', '2025-02-23 01:07:45', NULL, NULL, 1),
(6, 'buscartramite', 'Buscar Tramite', 'users', '../buscartramite/', '2025-02-23 01:07:45', NULL, NULL, 1),
(7, 'mntcolaborador', 'Mnt.Colaborador', 'users', '../mntusuario/', '2025-02-23 01:07:45', NULL, NULL, 1),
(8, 'mntarea', 'Mnt.Area', 'users', '../mntarea/', '2025-02-23 01:07:45', NULL, NULL, 1),
(9, 'mntramite', 'Mnt.Tramite', 'users', '../mntramite/', '2025-02-23 01:07:45', NULL, NULL, 1),
(10, 'mntipo', 'Mnt.Tipo', 'users', '../mntipo/', '2025-02-23 01:07:45', NULL, NULL, 1),
(11, 'mntrol', 'Mnt.Rol', 'users', '../mntrol/', '2025-02-23 01:07:45', NULL, NULL, 1);

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
(3, 'Administrador', '2025-02-09 16:13:50', NULL, NULL, 1),
(4, 'test', '2025-02-22 23:49:12', NULL, NULL, 1),
(5, 'test4', '2025-02-22 23:50:38', '2025-02-22 23:50:43', '2025-02-22 23:51:47', 0),
(6, 'test15', '2025-02-22 23:51:59', '2025-02-22 23:52:11', '2025-02-22 23:52:14', 0);

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
(1, 'Recepcion de Correspondencia Externa', 'Recepción y distribución de correspondencia externa a la empresa.', '2025-02-17 22:31:49', '2025-03-02 12:55:18', NULL, 1),
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
(88, 'Carlos Efra', 'prueba7777@gmail.com', 'lbOVzlHaJGybAfogB7gAHclUV/HDvHI0+7kTQX73vSg=', '2025-02-09 16:58:07', '', 2, NULL, NULL, NULL, 2),
(101, 'Edita Chafloque', 'echafloquecajusol@gmail.com', 'zL47+NpEe2k6yH07qQmoyHSxpr9gKUoQ52UMCTgzsA4=', '2025-02-10 22:04:09', '', 1, NULL, NULL, NULL, 2),
(102, 'Edita Cajusol', 'u20234626@utp.edu.pe', 'UQgStk/wNei0NNXdamOciH86OBIbF+ON17HXOSdh4Sg=', '2025-02-10 22:09:29', '', 1, NULL, NULL, NULL, 2),
(104, 'Carlos Efrain Chafloque Lllontop', 'carlosefrainchallo1@gmail.com', 'fJJYQHNZ4qTpVPyqBPobc/XTYa/CMKA/eOemqf+kL7s=', '2025-02-12 00:36:46', 'https://lh3.googleusercontent.com/a/ACg8ocIXAPS7fPlVdIejcDjDfBgg1Wc25rIzUtXy_IQvjXRFaXYSIL30=s96-c', 2, NULL, NULL, NULL, 1),
(105, 'Chafloque', 'seleccionchiclayo@dino.com.pe', 'hdhYrfMwr25wZlsJN01G2IT7doeDI/siJ4ohDqzJEXM=', '2025-02-12 00:37:35', 'https://lh3.googleusercontent.com/a/ACg8ocKd_Zky6TYjMc-8UNJJPMOBcdcA9F4vOCer41nDneuE1PDbhltl=s96-c', 3, '2025-03-02 13:12:58', NULL, NULL, 1),
(107, 'test777', 'teste777@gmail.com', NULL, '2025-02-17 23:25:57', '../../assets/picture/avatar.png', 3, '2025-02-21 00:57:44', '2025-02-21 00:58:05', NULL, 0),
(108, 'test1', 'test1@gmail.com', NULL, '2025-02-21 00:30:43', '../../assets/picture/avatar.png', 2, NULL, '2025-02-21 00:34:07', NULL, 0),
(109, 'test89', 'test89@gmail.com', NULL, '2025-02-21 00:34:22', '../../assets/picture/avatar.png', 3, '2025-02-21 01:14:46', '2025-02-21 01:16:54', NULL, 0),
(110, 'testefra', 'testefra@gmail.com', NULL, '2025-02-21 00:58:01', '../../assets/picture/avatar.png', 2, NULL, '2025-02-21 00:58:08', NULL, 0),
(111, 'carlos efraincito', 'efraincito@gmail.com', NULL, '2025-02-21 00:59:44', '../../assets/picture/avatar.png', 2, '2025-03-02 12:57:20', NULL, NULL, 1),
(112, 'Cinthia', 'Cinthia@gmail.com', NULL, '2025-02-21 01:16:38', '../../assets/picture/avatar.png', 2, NULL, '2025-02-22 11:08:54', NULL, 0),
(113, 'Diego Marquin', 'dm@gmail.com', NULL, '2025-02-21 01:17:15', '../../assets/picture/avatar.png', 3, '2025-02-21 01:17:20', '2025-02-22 11:08:58', NULL, 0),
(116, 'Calin', 'u19309934@utp.edu.pe', 'hiZAUlpuhN42P4S26RQR7FCCsDgoaK5CNoalBnPTbyE=', '2025-02-22 12:18:53', '../../assets/picture/avatar.png', 1, '2025-02-26 01:41:31', NULL, NULL, 1),
(118, 'Brenda Anahi', 'u23204320@utp.edu.pe', 'ffMOrfhZM3WOsyL5aBmrAMDmXmTs+Tr6zM5Kw5HIcMk=', '2025-02-22 12:21:50', '../../assets/picture/avatar.png', 2, '2025-03-02 17:07:32', NULL, NULL, 1),
(119, 'vanessa', 'vanessa@gmail.com', 'KVMGSWvtFfeuVpkkP3pte5usJsGCuBD7UyYUqucwbZI=', '2025-02-26 01:53:52', '../../assets/picture/avatar.png', 1, NULL, NULL, NULL, 1),
(120, 'Raul Armando', 'raul1@gmail.com', 'KDDvnd7OEMmr+tBLJyV9+uTm1iU9/BnH1g7LiMuy2uc=', '2025-02-26 01:55:34', '../../assets/picture/avatar.png', 2, '2025-03-02 17:07:47', '2025-03-02 20:34:02', NULL, 0),
(121, 'Jose Carlos Guzman Perez', 'guzmanperezjosecarlos33@gmail.com', '7SlUYGb2KJPM4rKxbqt9K9XIB+82Pl5LFqx651hwF2M=', '2025-02-26 02:03:29', 'https://lh3.googleusercontent.com/a/ACg8ocKH3ZMrm2oG3vVbdQXyGg9ErisudMgfCW4r1fUkYTka8rESrg=s96-c', 1, NULL, NULL, NULL, 1),
(124, 'Eduardo Zuñe', 'eduardozune3@gmail.com', 'wrCK059aCVH8GJBgqb9bfCq4FYXVvCv9TjqIedUczFc=', '2025-03-02 17:10:51', 'https://lh3.googleusercontent.com/a/ACg8ocJ_NjFfzgvSe-ToY7IPgiP8s5FSkmk2fiHIXRxWisGjl9sqmg=s96-c', 1, NULL, NULL, NULL, 1),
(125, 'Groupsy', 'groupsy777@gmail.com', 'O/ZR0PYzQowG/kP4DZGDNRrWa8w2u/V+3yZkuxV7baw=', '2025-03-02 20:33:00', 'https://lh3.googleusercontent.com/a/ACg8ocJPe5klMxSja5_GXW6Xe-vpi1zUUt9rSGLGsdkvyLJbw_kjfQ=s96-c', 1, NULL, NULL, NULL, 1),
(126, 'Prueba Buena suerte Efra', 'Carloschallo1@hotmail.com', 'uVtUQm58HAypGnmvrAmwA/dEBEhcFVbRl4/QbI9Mw8Y=', '2025-03-02 20:35:48', '../../assets/picture/avatar.png', 2, NULL, NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `td_area_detalle`
--
ALTER TABLE `td_area_detalle`
  ADD PRIMARY KEY (`aread_id`);

--
-- Indices de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  ADD PRIMARY KEY (`det_id`);

--
-- Indices de la tabla `td_menu_detalle`
--
ALTER TABLE `td_menu_detalle`
  ADD PRIMARY KEY (`mend_id`);

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
-- Indices de la tabla `tm_menu`
--
ALTER TABLE `tm_menu`
  ADD PRIMARY KEY (`men_id`);

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
-- AUTO_INCREMENT de la tabla `td_area_detalle`
--
ALTER TABLE `td_area_detalle`
  MODIFY `aread_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  MODIFY `det_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT de la tabla `td_menu_detalle`
--
ALTER TABLE `td_menu_detalle`
  MODIFY `mend_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `tm_area`
--
ALTER TABLE `tm_area`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tm_documento`
--
ALTER TABLE `tm_documento`
  MODIFY `doc_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `tm_menu`
--
ALTER TABLE `tm_menu`
  MODIFY `men_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tm_rol`
--
ALTER TABLE `tm_rol`
  MODIFY `rol_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
