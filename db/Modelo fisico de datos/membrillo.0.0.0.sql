SET default_storage_engine=InnoDB;
/*
Created: 24/03/2021
Modified: 1/04/2021
Model: membrillo
Database: MySQL 8.0
*/

-- Create tables section -------------------------------------------------

-- Table product

CREATE TABLE `product`
(
  `uuid` Varchar(36) NOT NULL,
  `idproduct` Varchar(128),
  `uuidCatalog` Varchar(36) NOT NULL,
  `idCatalog` Varchar(128),
  `title` Varchar(128) NOT NULL,
  `descriptionHtml` Varchar(256) NOT NULL,
  `price` Int NOT NULL,
  `stock` Int NOT NULL,
  `altTextImg` Varchar(256) NOT NULL,
  `src` Varchar(256) NOT NULL
)
;

CREATE INDEX `IX_Relationship1` ON `product` (`uuidCatalog`)
;

ALTER TABLE `product` ADD PRIMARY KEY (`uuid`)
;

-- Table fact

CREATE TABLE `fact`
(
  `uuid` Varchar(36) NOT NULL,
  `uuidClient` Varchar(36) NOT NULL,
  `dateCreation` Datetime NOT NULL
)
;

CREATE INDEX `IX_Relationship2` ON `fact` (`uuidClient`)
;

ALTER TABLE `fact` ADD PRIMARY KEY (`uuid`)
;

-- Table client

CREATE TABLE `client`
(
  `uuid` Varchar(36) NOT NULL,
  `name` Varchar(128) NOT NULL,
  `lastName` Varchar(128) NOT NULL,
  `nit` Varchar(16) NOT NULL
)
;

ALTER TABLE `client` ADD PRIMARY KEY (`uuid`)
;

-- Table catalog

CREATE TABLE `catalog`
(
  `uuid` Varchar(36) NOT NULL,
  `id` Varchar(128),
  `catalog` Varchar(128) NOT NULL,
  `descriptionHtml` Varchar(256) NOT NULL,
  `img` Varchar(256) NOT NULL,
  `altTextimg` Varchar(256) NOT NULL
)
;

ALTER TABLE `catalog` ADD PRIMARY KEY (`uuid`)
;

-- Table description

CREATE TABLE `description`
(
  `uuidInventory` Varchar(36) NOT NULL,
  `uuidFact` Varchar(36) NOT NULL,
  `price` Decimal(10,2) NOT NULL,
  `amount` Int NOT NULL
)
;

ALTER TABLE `description` ADD PRIMARY KEY (`uuidFact`, `uuidInventory`)
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE `product` ADD CONSTRAINT `Relationship1` FOREIGN KEY (`uuidCatalog`) REFERENCES `catalog` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `fact` ADD CONSTRAINT `Relationship2` FOREIGN KEY (`uuidClient`) REFERENCES `client` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `description` ADD CONSTRAINT `Relationship5` FOREIGN KEY (`uuidFact`) REFERENCES `fact` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `description` ADD CONSTRAINT `Relationship6` FOREIGN KEY (`uuidInventory`) REFERENCES `product` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

