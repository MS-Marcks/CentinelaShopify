DELIMITER $$
CREATE PROCEDURE `sp_search_product_createShopify` (
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
END$$

DELIMITER  $$
CREATE PROCEDURE `sp_update_product_createShopify` (
in puuid VARCHAR (36),in pidproduct VARCHAR(128),in pidCatalog VARCHAR(128))
BEGIN
   UPDATE product SET idproduct=pidproduct,idCatalog=pidCatalog WHERE uuid = puuid;
END$$


INSERT INTO product(uuid,uuidCatalog,title,descriptionHtml,price,stock,altTextImg,src)
VALUES(UUID(),"f57412df-930c-11eb-915a-b05216480f51","apple","<h1>PRUEBA</h1>",20,10,"IMAGE","https://imagenmix.net/wp-content/uploads/2016/09/imagenes-bonitas-chidas.jpg");