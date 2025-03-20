import http from "node:http";
import { stock } from "./database/stock.mjs";

const server = http.createServer();

server.addListener("request", (req, res) => {
  const urlObject = new URL(`http://${req.headers.host}${req.url}`);
  console.log(urlObject);

  if (urlObject.pathname === "/") {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.write(`
      <h1>Stock Management System</h1>
      <ul>
        <li><a href="/api/stock">Get all stock items</a></li>
        <li><a href="/api/unavailable-stock">Get unavailable stock items</a></li>
        <li>
          <label>Busca de produto por ID</label>
          <input type="text" id="searchInput" placeholder="ID do produto">
          <button onclick="searchProduct()">Buscar</button>
        </li>
      </ul>

      <script>
        function searchProduct() {
          const input = document.getElementById("searchInput").value;
          if (input) {
            window.location.href = "/api/get-product-by-id?id=" + input;
          }
      </script>
    `);
    res.end();
  }

  if (urlObject.pathname === "/api/stock") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify(stock));
    res.end();
  }

  if (urlObject.pathname === "/api/unavailable-stock") {
    const unavailableProducts = stock.filter(
      (product) => product.quantity === 0
    );
    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify(unavailableProducts));
    res.end();
  }

  if (urlObject.pathname === "/api/get-product-by-id") {
    const paramsId = urlObject.searchParams.get("id");
    if (!paramsId || isNaN(paramsId)) {
      res.writeHead(400, { "Content-Type": "text/plain" });
      res.write("Invalid or missing product ID");
      res.end();
      return;
    }
    const product = stock.find((product) => product.id === parseInt(paramsId));

    if (!product) {
      res.writeHead(404, { "Content-Type": "text/plain" });
      res.write("Product not found");
      res.end();
      return;
    }

    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(JSON.stringify(product));
    res.end();
  }
});

server.listen(8000, () => {
  console.log("Server running on port 8000");
});
