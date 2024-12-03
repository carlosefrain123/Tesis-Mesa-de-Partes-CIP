-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3305
-- Tiempo de generación: 03-12-2024 a las 11:39:15
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE `tm_usuario` (
  `user_id` int(10) NOT NULL,
  `usu_nomape` varchar(90) NOT NULL,
  `usu_correo` varchar(50) NOT NULL,
  `usu_pass` varchar(200) NOT NULL,
  `fech_crea` datetime NOT NULL DEFAULT current_timestamp(),
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `fech_acti` datetime DEFAULT NULL,
  `est` int(10) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`user_id`, `usu_nomape`, `usu_correo`, `usu_pass`, `fech_crea`, `fech_modi`, `fech_elim`, `fech_acti`, `est`) VALUES
(39, 'prueba', 'prueba@gmail.com', '12345678', '2024-11-10 01:32:40', NULL, NULL, NULL, 2),
(40, 'prueba2', 'prueba2@gmail.com', '12345678', '2024-11-10 01:34:40', NULL, NULL, NULL, 2),
(41, 'prueba3', 'prueba4@gmail.com', '12345678', '2024-11-10 01:39:40', NULL, NULL, NULL, 2),
(42, 'prueba3', 'prueba5@gmail.com', '987654321', '2024-11-10 01:39:54', NULL, NULL, NULL, 2),
(43, 'prueba7', 'prueba7@gmail.com', '12345678', '2024-11-10 01:43:05', NULL, NULL, NULL, 2),
(44, 'prueba3', 'prueba8@gmail.com', '12345678', '2024-11-10 01:48:45', NULL, NULL, NULL, 2),
(45, 'prueba9', 'prueba9@gmail.com', '12345678', '2024-11-10 02:15:27', NULL, NULL, NULL, 2),
(46, 'prueba10', 'prueba10@gmail.com', '12345678', '2024-11-10 02:16:24', NULL, NULL, NULL, 2),
(47, 'prueba15', 'prueba15@gmail.com', '12345678', '2024-11-11 21:12:34', NULL, NULL, NULL, 2),
(48, 'prueba16', 'prueba16@gmail.com', '12345678', '2024-11-11 21:15:19', NULL, NULL, '2024-11-27 00:35:45', 1),
(49, 'prueba11', 'prueba11@gmail.com', '12345678', '2024-11-11 21:21:52', NULL, NULL, NULL, 2),
(50, 'prueba12', 'prueba12@gmail.com', '12345678', '2024-11-19 23:40:00', NULL, NULL, '2024-11-27 00:32:55', 1),
(63, 'prueba20', 'u19309934@utp.edu.pe', '12345678', '2024-11-27 01:19:12', NULL, NULL, NULL, 2),
(66, 'prueba19', 'Carloschallo1@hotmail.com', 'ZJmddEXCBgyY9yf4+01Wj0f4aZmHUhIvhfSBHN44ves=', '2024-11-27 02:03:43', NULL, NULL, '2024-11-27 02:04:36', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
