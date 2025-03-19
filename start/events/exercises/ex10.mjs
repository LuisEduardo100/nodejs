// Exercício 10: Crie um programa Node.js que leia o conteúdo de um arquivo de texto e, ao
// terminar de ler, emita um evento fileReadSuccess com o conteúdo lido. Em seguida,
// escreva esse conteúdo em um novo arquivo e, ao finalizar a escrita, emita um evento
// fileWriteSuccess

import EventEmitter from "events";
import fs from "fs";

class FileSystem extends EventEmitter {
  readFile(filePath) {
    fs.readFile(filePath, "utf-8", (err, data) => {
      if (data.length == 0) {
        console.log("Arquivo vazio!");
        return;
      }

      if (err) {
        this.emit("fileReadFailure", err);
      } else {
        this.emit("fileReadSuccess", data);
      }
    });
  }

  writeFile(filePath, content) {
    fs.writeFile(filePath, content, (err) => {
      if (err) {
        this.emit("fileWriteFailure", err);
      } else {
        this.emit("fileWriteSuccess", filePath);
      }
    });
  }
}

const fileSystem = new FileSystem();

fileSystem.on("fileReadSuccess", (data) => {
  console.log("Arquivo lido com sucesso!");
  console.log(`Conteúdo lido: ${data}`);
  fileSystem.writeFile("output.txt", data);
});

fileSystem.on("fileReadFailure", (err) => {
  console.error("Erro ao ler arquivo:", err);
});

fileSystem.on("fileWriteSuccess", (filePath) => {
  console.log(`Arquivo escrito com sucesso em: ${filePath}`);
});

fileSystem.on("fileWriteFailure", (err) => {
  console.error("Erro ao escrever arquivo:", err);
});

fileSystem.readFile("input.txt");
