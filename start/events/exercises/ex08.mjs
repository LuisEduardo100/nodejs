// Exercício 8: Crie um sistema de log que herda de EventEmitter e registra todos os eventos
// emitidos, como login, logout e error. O sistema deve armazenar as mensagens de log e,
// ao final de cada dia (simulado por um intervalo de tempo de 5 segundos), emita um evento
// dailyLogReport com um resumo de todos os logs do dia.

import EventEmitter from "node:events";

class logSystem extends EventEmitter {
  constructor() {
    super();
    this.logList = [];
    this.intervalID = null;
    this.startDailyReport();
  }

  newEvent(event, message) {
    const log = {
      event,
      message,
      data: new Date().toISOString(),
    };
    this.logList.push(log);
    this.emit("newEvent", log);
  }

  startDailyReport() {
    this.intervalID = setInterval(() => {
      this.emit("dailyLogReport", this.logList);
      this.logList = [];
    }, 5000);
  }

  stopReport() {
    if (this.intervalID) {
      clearInterval(this.intervalID);
      console.log("Daily report stopped");
    }
  }
}

const log = new logSystem();

log.on("newEvent", (log) => {
  console.log(`New event: ${log.event} - ${log.message} - ${log.data}`);
});

log.on("dailyLogReport", (logs) => {
  console.log("Daily log report:");
  logs.forEach((log) => {
    console.log(`- ${log.event} - ${log.message} - Data: ${log.data}`);
  });
});

log.newEvent("login", "Admin user logged in");
log.newEvent("logout", "Admin user logged out");
log.newEvent("error", "Error to load the page");

setTimeout(() => {
  log.stopReport();
}, 9000); // Simulate 10 seconds for the daily report to be generated.
