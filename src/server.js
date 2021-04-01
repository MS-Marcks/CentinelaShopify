'use strict';
if (process.env.NODE_ENV !== 'production') {
  require("dotenv").config()
}

import { CronJob } from 'cron';
import { GraphQLClient, gql } from 'graphql-request'
import { query } from './Config/query';

async function GraphQL(ql, variables, verify = false) {
  const endpoint = process.env.BASE_URL_SHOPIFY;
  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      "X-Shopify-Access-Token": process.env.TOKEN_SHOPIFY,
    },
  })
  const body = gql`${ql}`;
  if (verify) {
    const data = await graphQLClient.request(body, variables)
    return data;
  } else {
    const data = await graphQLClient.request(body)
    return data;
  }
}

async function Catalog_createShopify() {
  const q = await query(`CALL sp_search_catalog_createShopify`);
  if (q.code === 200) {
    const result = q.query[0];
    if (result.length !== 0) {
      for (let index = 0; index < result.length; index++) {
        const e = result[index];
        const variables = {
          input: {
            descriptionHtml: e.descriptionHtml,
            title: e.catalog,
            image: {
              altText: e.altTextimg,
              src: e.img
            }
          }
        };
        const data = await GraphQL(`mutation collectionCreate($input: CollectionInput!) {
          collectionCreate(input: $input) {
            collection {
              id
            }
            userErrors {
              field
              message
            }
          }
        }`, variables, true);
        const q = await query(`CALL sp_update_catalog_createShopify(?,?)`, [e.uuid, data.collectionCreate.collection.id]);
      }
    }

  } else if (q.code === 404) {
    const result = q.err;
  }
}

async function Product_createShopify() {

  const q = await query(`CALL sp_search_catalog_Product_createShopify`);
  if (q.code === 200) {
    const result = q.query[0];
    if (result.length !== 0) {
      for (let i = 0; i < result.length; i++) {
        const catalog = result[i];
        const qs = await query(`CALL sp_search_product_createShopify (?)`, [catalog.uuid]);
        if (qs.code === 200) {
          const resultproduct = qs.query[0];
          if (resultproduct.length !== 0) {
            for (let j = 0; j < resultproduct.length; j++) {
              const e = resultproduct[j];
              const variables = {
                input: {
                  title: e.title,
                  descriptionHtml: e.descriptionHtml,
                  vendor: "membrilloss",
                  collectionsToJoin: catalog.id,
                  variants: {
                    price: e.price,
                    inventoryItem: {
                      tracked: true
                    },
                    inventoryQuantities: {
                      availableQuantity: e.stock,
                      locationId: "gid://shopify/Location/61836787909"
                    }
                  },
                  images: {
                    altText: e.altTextImg,
                    src: e.src
                  }
                }
              };
              const data = await GraphQL(`mutation productCreate($input: ProductInput!) {
                productCreate(input: $input) {
                  product {
                    id
                  }
                  userErrors {
                    field
                    message
                  }
                }
              }`, variables, true);
              const qw = await query(`CALL sp_update_product_createShopify(?,?,?)`, [e.uuid, data.productCreate.product.id,catalog.id]);
            }
          }
        } else if (qs.code === 404) {
          const result = qs.err;
        }
      }
    }
  } else if (q.code === 404) {
    const result = q.err;
  }
}

const app = async () => {
  
  console.log("INICIO-VERIFICACION DE CATALOGOS");
  await Catalog_createShopify();
  console.log("FINAL-VERIFICACION DE CATALOGOS");
  console.log("INICIO-VERIFICACION DE PRODUCTOS");
  await Product_createShopify();
  console.log("FINAL-VERIFICACION DE PRODUCTOS");
}
var job = new CronJob('*/5 * * * * *', () => {
app();
}, null, true, 'America/Los_Angeles');
job.start();