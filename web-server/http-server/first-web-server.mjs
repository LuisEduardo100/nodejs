import http from "node:http";
import url from "node:url";
import fs from "node:fs/promises";
import { createReadStream } from "node:fs";

const server = http.createServer();

server.on("request", async (request, response) => {
  const filePath = url.parse(request.url).pathname;
  const processPath = process.cwd(); // retorna o caminho do diretório

  try {
    await fs.stat(processPath + filePath);
    const readStream = createReadStream(processPath + filePath);
    response.writeHead(200, { "Content-type": "text/html" });
    readStream.pipe(response);
  } catch {
    response.writeHead(404, { "Content-type": "text/plain" });
    response.write("File not found");
    response.end();
  }
});

server.listen(8000, () => {
  console.log("Server running on port 8000");
});
