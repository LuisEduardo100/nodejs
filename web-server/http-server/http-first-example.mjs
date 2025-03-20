import http from "node:http";

const server = http.createServer();
server.addListener("request", (request, response) => {
  response.writeHead(200, { "Content-Type": "text/html" });
  response.write("Hello, champs!");
  response.end();
});

server.listen(8000, () => {
  console.log("Servidor rodando na porta 8000");
});
