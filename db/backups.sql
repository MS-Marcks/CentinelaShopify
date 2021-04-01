/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ membrillos /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE membrillos;

DROP TABLE IF EXISTS catalog;
CREATE TABLE `catalog` (
  `uuid` varchar(36) NOT NULL,
  `id` varchar(128) DEFAULT NULL,
  `catalog` varchar(128) NOT NULL,
  `descriptionHtml` varchar(256) DEFAULT NULL,
  `img` varchar(256) NOT NULL,
  `altTextimg` varchar(256) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS product;
CREATE TABLE `product` (
  `uuid` varchar(36) NOT NULL,
  `idproduct` varchar(128) DEFAULT NULL,
  `uuidCatalog` varchar(36) NOT NULL,
  `idCatalog` varchar(128) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `descriptionHtml` varchar(256) NOT NULL,
  `price` int NOT NULL,
  `stock` int NOT NULL,
  `altTextImg` varchar(256) NOT NULL,
  `src` varchar(256) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP PROCEDURE IF EXISTS sp_search_catalog_createShopify;
CREATE PROCEDURE `sp_search_catalog_createShopify`()
BEGIN
   SELECT uuid,id,catalog,descriptionHtml,img,altTextimg FROM catalog WHERE id IS NULL;
END;

DROP PROCEDURE IF EXISTS sp_search_catalog_Product_createShopify;
CREATE PROCEDURE `sp_search_catalog_Product_createShopify`()
BEGIN
   SELECT uuid,id,catalog,descriptionHtml,img,altTextimg FROM catalog WHERE id IS NOT NULL;
END;

DROP PROCEDURE IF EXISTS sp_search_product_createShopify;
CREATE PROCEDURE `sp_search_product_createShopify`(
    in puuidCatalog VARCHAR (36)
)
BEGIN
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
END;

DROP PROCEDURE IF EXISTS sp_update_catalog_createShopify;
CREATE PROCEDURE `sp_update_catalog_createShopify`(
in puuid VARCHAR (36),in pid VARCHAR(128))
BEGIN
   UPDATE catalog SET id=pid WHERE uuid = puuid;
END;

DROP PROCEDURE IF EXISTS sp_update_product_createShopify;
CREATE PROCEDURE `sp_update_product_createShopify`(
in puuid VARCHAR (36),in pidproduct VARCHAR(128),in pidCatalog VARCHAR(128))
BEGIN
   UPDATE product SET idproduct=pidproduct,idCatalog=pidCatalog WHERE uuid = puuid;
END;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
