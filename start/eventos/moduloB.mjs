import { eventEmitter } from "./moduloA.mjs";

eventEmitter.on("eventoDoModuloA", (dados) => {
  console.log(`Evento recebido no módulo B: ${dados}`);
});
