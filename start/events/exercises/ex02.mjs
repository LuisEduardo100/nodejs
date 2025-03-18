import { EventEmitter } from "node:events";

const emissor = new EventEmitter();

// Exercício 2: Altere o código anterior para que o evento mensagemRecebida aceite um
// argumento contendo a mensagem recebida e exiba essa mensagem no console.
emissor.on("mensagemRecebida", (msg) => {
  console.log("Mensagem recebida com sucesso:\n" + msg);
});

emissor.emit("mensagemRecebida", "Mensagem recebida na requisição");
