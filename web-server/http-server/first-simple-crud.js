import http from "node:http";
import { product } from "./database/product.js";
import { save } from "./database/database-functions.js";
import { parseJsonBody } from "./middlewares/json-parser.js";

const server = http.createServer((req, res) => {
  const urlObject = new URL(`http://${req.headers.host}${req.url}`);

  if (urlObject.pathname === "/products" && req.method === "GET") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify(product));
    res.end();
  } else if (
    urlObject.pathname === "/products/get-by-id" &&
    req.method === "GET"
  ) {
    const id = parseInt(urlObject.searchParams.get("id"));
    const productFound = product.find((p) => p.id === id);
    if (!productFound) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("Product not found");
      return;
    }

    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify(productFound));
  } else if (urlObject.pathname === "/products" && req.method === "POST") {
    parseJsonBody(req, (err, data) => {
      if (err) {
        res.writeHead(400, { "Content-Type": "application/json" });
        res.end(JSON.stringify({ error: "Invalid JSON format" }));
        return;
      }

      const { name, description, price } = data;

      const newProduct = {
        id: product[product.length - 1].id + 1,
        name,
        description,
        price,
      };

      product.push(newProduct);
      save(product);

      res.writeHead(201, { "Content-Type": "application/json" });
      res.end(
        JSON.stringify({
          message: "Product created",
          product: {
            id: newProduct.id,
            name: newProduct.name,
            description: newProduct.description,
            price: newProduct.price,
          },
        })
      );
    });
  } else if (urlObject.pathname === "/products" && req.method === "PUT") {
    parseJsonBody(req, (err, data) => {
      if (err) {
        res.writeHead(400, { "Content-Type": "text/plain" });
        res.end("Invalid request payload");
        return;
      }

      const paramsId = parseInt(urlObject.searchParams.get("id"));

      if (!paramsId) {
        res.writeHead(400, { "Content-Type": "text/plain" });
        res.end("Invalid or missing product ID");
        return;
      }

      const { name, description, price } = data;
      const updatedProduct = {
        id: paramsId,
        name,
        description,
        price,
      };

      const index = product.findIndex((product) => product.id === paramsId);
      product[index] = updatedProduct;
      save(product);

      res.writeHead(200, { "Content-Type": "application/json" });
      res.end(
        JSON.stringify({
          message: "Product updated",
          product: {
            id: updatedProduct.id,
            name: updatedProduct.name,
            description: updatedProduct.description,
            price: updatedProduct.price,
          },
        })
      );
    });
  } else if (urlObject.pathname === "/products" && req.method === "DELETE") {
    const paramsId = parseInt(urlObject.searchParams.get("id"));
    if (!paramsId) {
      res.writeHead(400, { "Content-Type": "text/plain" });
      res.end("Invalid or missing product ID");
      return;
    }

    const index = product.findIndex((product) => product.id === paramsId);

    if (index === -1) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.end("Product not found");
      return;
    }

    product.splice(index, 1);
    save(product);

    res.writeHead(204, { "Content-Type": "application/json" });
    res.end();
  } else {
    res.writeHead(404, { "Content-Type": "text/plain" });
    res.end("Rota não encontrada");
  }
});

server.listen(8000, () => {
  console.log("Server running on port 8000");
});
