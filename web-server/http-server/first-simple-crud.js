import http from "node:http";
import { product } from "./database/product.js";
import bodyParser from "body-parser";
import { save } from "./database/database-functions.js";

const server = http.createServer((req, res) => {
  const urlObject = new URL(`http://${req.headers.host}${req.url}`);

  if (urlObject.pathname === "/products" && req.method === "GET") {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.write(JSON.stringify(product));
    res.end();
  } else if (urlObject.pathname === "/products" && req.method === "POST") {
    bodyParser.json()(req, res, (err) => {
      if (err) {
        res.writeHead(400, { "Content-Type": "text/plain" });
        res.end("Invalid request payload");
        return;
      }

      const { name, description, price } = req.body;

      const newProduct = {
        id: product.length + 1,
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
  } else {
    res.writeHead(404, { "Content-Type": "text/plain" });
    res.end("Rota não encontrada");
  }
});

server.listen(8000, () => {
  console.log("Server running on port 8000");
});
