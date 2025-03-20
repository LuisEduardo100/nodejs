import http from "node:http";
import { stock } from "./database/stock.mjs";

const server = http.createServer();

server.addListener("request", (req, res) => {
  if (req.url === "/") {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.write(`
      <h1>Stock Management System</h1>
      <ul>
        <li><a href="/api/stock">Get all stock items</a></li>
        <li><a href="/api/unavailableStock">Get unavailable stock items</a></li>
      </ul>
    `);
    res.end();
  }

  if (req.url === "/api/stock") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify(stock));
    res.end();
  }

  if (req.url === "/api/unavailable-stock") {
    const unavailableProducts = stock.filter(
      (product) => product.quantity === 0
    );
    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify(unavailableProducts));
    res.end();
  }
});

server.listen(8000, () => {
  console.log("Server running on port 8000");
});
