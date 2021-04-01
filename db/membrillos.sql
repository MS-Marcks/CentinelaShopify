-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 02-04-2021 a las 06:29:55
-- Versión del servidor: 5.7.30-0ubuntu0.18.04.1-log
-- Versión de PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `membrillos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE  PROCEDURE `sp_search_catalog_createShopify` ()  BEGIN
   SELECT uuid,id,catalog,descriptionHtml,img,altTextimg FROM catalog WHERE id IS NULL;
END$$

CREATE  PROCEDURE `sp_search_catalog_Product_createShopify` ()  BEGIN
   SELECT uuid,id,catalog,descriptionHtml,img,altTextimg FROM catalog WHERE id IS NOT NULL;
END$$

CREATE  PROCEDURE `sp_search_product_createShopify` (IN `puuidCatalog` VARCHAR(36))  BEGIN
   SELECT 
    uuid,
    idproduct,
    uuidCatalog,
    idCatalog,
    title,
    descriptionHtml,
    price,
    stock,
    altTextImg,
    src
    FROM product WHERE idproduct IS NULL AND uuidCatalog = puuidCatalog;
END$$

CREATE PROCEDURE `sp_search_product_Shopify` ()  BEGIN
   SELECT  COUNT(1) AS amount FROM product WHERE idproduct IS NULL;
END$$

CREATE  PROCEDURE `sp_update_catalog_createShopify` (IN `puuid` VARCHAR(36), IN `pid` VARCHAR(128))  BEGIN
   UPDATE catalog SET id=pid WHERE uuid = puuid;
END$$

CREATE  PROCEDURE `sp_update_product_createShopify` (IN `puuid` VARCHAR(36), IN `pidproduct` VARCHAR(128), IN `pidCatalog` VARCHAR(128))  BEGIN
   UPDATE product SET idproduct=pidproduct,idCatalog=pidCatalog WHERE uuid = puuid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalog`
--

CREATE TABLE `catalog` (
  `uuid` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `id` varchar(128) COLLATE utf8_spanish_ci DEFAULT NULL,
  `catalog` varchar(128) COLLATE utf8_spanish_ci NOT NULL,
  `descriptionHtml` varchar(256) COLLATE utf8_spanish_ci NOT NULL,
  `img` varchar(256) COLLATE utf8_spanish_ci NOT NULL,
  `altTextimg` varchar(256) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client`
--

CREATE TABLE `client` (
  `uuid` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `name` varchar(128) COLLATE utf8_spanish_ci NOT NULL,
  `lastName` varchar(128) COLLATE utf8_spanish_ci NOT NULL,
  `nit` varchar(16) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `description`
--

CREATE TABLE `description` (
  `uuidInventory` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `uuidFact` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fact`
--

CREATE TABLE `fact` (
  `uuid` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `uuidClient` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `dateCreation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

CREATE TABLE `product` (
  `uuid` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `idproduct` varchar(128) COLLATE utf8_spanish_ci DEFAULT NULL,
  `uuidCatalog` varchar(36) COLLATE utf8_spanish_ci NOT NULL,
  `idCatalog` varchar(128) COLLATE utf8_spanish_ci DEFAULT NULL,
  `title` varchar(128) COLLATE utf8_spanish_ci NOT NULL,
  `descriptionHtml` varchar(256) COLLATE utf8_spanish_ci NOT NULL,
  `price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `altTextImg` varchar(256) COLLATE utf8_spanish_ci NOT NULL,
  `src` varchar(256) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `catalog`
--
ALTER TABLE `catalog`
  ADD PRIMARY KEY (`uuid`);

--
-- Indices de la tabla `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`uuid`);

--
-- Indices de la tabla `description`
--
ALTER TABLE `description`
  ADD PRIMARY KEY (`uuidFact`,`uuidInventory`),
  ADD KEY `Relationship6` (`uuidInventory`);

--
-- Indices de la tabla `fact`
--
ALTER TABLE `fact`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `IX_Relationship2` (`uuidClient`);

--
-- Indices de la tabla `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `IX_Relationship1` (`uuidCatalog`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `description`
--
ALTER TABLE `description`
  ADD CONSTRAINT `Relationship5` FOREIGN KEY (`uuidFact`) REFERENCES `fact` (`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Relationship6` FOREIGN KEY (`uuidInventory`) REFERENCES `product` (`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `fact`
--
ALTER TABLE `fact`
  ADD CONSTRAINT `Relationship2` FOREIGN KEY (`uuidClient`) REFERENCES `client` (`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `Relationship1` FOREIGN KEY (`uuidCatalog`) REFERENCES `catalog` (`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
