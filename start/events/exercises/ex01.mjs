import { EventEmitter } from "node:events";

const emissor = new EventEmitter();

// Exercício 1: Crie um programa Node.js onde você tenha um EventEmitter. Emita um evento
// chamado mensagemRecebida e ouça esse evento para exibir a mensagem "Mensagem
// recebida com sucesso!".
emissor.on("mensagemRecebida", () => {
  console.log("Mensagem recebida com sucesso");
});

emissor.emit("mensagemRecebida");
