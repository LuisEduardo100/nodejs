import EventEmitter from "node:events";

const eventEmitter = new EventEmitter();

setTimeout(() => {
  eventEmitter.emit("eventoDoModuloA", "Dados do Modulo A");
}, 2000);

export { eventEmitter };
