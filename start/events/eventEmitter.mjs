import { EventEmitter } from "node:events";

const eventEmitter = new EventEmitter();

eventEmitter.addListener("eventoPersonalizado1", (mensagem) => {
  console.log("Evento acionado com addListener()");
});

eventEmitter.on("eventoPersonalizado2", (mensagem) => {
  console.log(`Mensagem recebida: ${mensagem}`);
});

eventEmitter.on("eventoPersonalizado3", () => {
  console.log("Evento acionado com on()");
});

eventEmitter.emit(
  "eventoPersonalizado1",
  "Olá, este é um evento personalizado."
);
