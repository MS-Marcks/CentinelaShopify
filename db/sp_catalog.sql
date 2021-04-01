
DELIMITER $$
CREATE PROCEDURE `sp_search_catalog_createShopify` ()
BEGIN
   SELECT uuid,id,catalog,descriptionHtml,img,altTextimg FROM catalog WHERE id IS NULL;
END$$

DELIMITER $$
CREATE PROCEDURE `sp_search_catalog_Product_createShopify` ()
BEGIN
   SELECT uuid,id,catalog,descriptionHtml,img,altTextimg FROM catalog WHERE id IS NOT NULL;
END$$


DELIMITER  $$
CREATE PROCEDURE `sp_update_catalog_createShopify` (
in puuid VARCHAR (36),in pid VARCHAR(128))
BEGIN
   UPDATE catalog SET id=pid WHERE uuid = puuid;
END$$


INSERT INTO catalog(uuid,catalog,descriptionHtml,img,altTextimg) VALUES(UUID(),"frutas","<h1>PRUEBA</h1>","https://imagenmix.net/wp-content/uploads/2016/09/imagenes-bonitas-chidas.jpg","PRUEBA");
INSERT INTO catalog(uuid,catalog,descriptionHtml,img,altTextimg) VALUES(UUID(),"verduras","<h1>PRUEBA</h1>","https://imagenmix.net/wp-content/uploads/2016/09/imagenes-bonitas-chidas.jpg","PRUEBA");