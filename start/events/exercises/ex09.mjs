// Exercício 9: Crie um EventEmitter que emite o evento ping a cada segundo. O evento ping
// deve ser emitido no máximo 5 vezes. Após a quinta emissão, o processo deve ser finalizado
// emitindo um evento pingFinished.

import EventEmitter from "node:events";

class PingEmitter extends EventEmitter {
  constructor() {
    super();
    this.pingCount = 0;
    this.maxPing = 5;
  }

  pingStart() {
    const intervalID = setInterval(() => {
      this.pingCount++;
      if (this.pingCount <= this.maxPing) {
        this.emit("ping", this.pingCount);
      } else {
        this.emit("pingFinished");
        clearInterval(intervalID);
      }
    }, 1000);
  }
}

const pingEmitter = new PingEmitter();

pingEmitter.on("ping", (pingCount) => {
  console.log(`ping ${pingCount}`);
});
pingEmitter.on("pingFinished", () => {
  console.log("max ping reached");
});

pingEmitter.pingStart();
