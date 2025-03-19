import EventEmitter from "node:events";

// Exercício 7: Crie um sistema de fila que herde de EventEmitter. A fila deve permitir
// adicionar "tarefas" (strings) e processá-las uma por vez a cada 2 segundos, emitindo um evento
// taskProcessed cada vez que uma tarefa for completada. Quando todas as tarefas forem
// processadas, emita um evento allTasksProcessed.

class QueueSystem extends EventEmitter {
  constructor() {
    super();
    this.taskList = [];
    this.process = false;
  }

  addToList(task) {
    this.taskList.push(task);
    if (!this.process) {
      this.processTask();
    }
  }

  processTask() {
    if (this.taskList.length > 0) {
      this.process = true;
      const nextTask = this.taskList.shift();
      setTimeout(() => {
        this.emit("taskProcessed", nextTask);
        this.processTask();
      }, 2000);
    } else {
      this.process = false;
      this.emit("allTasksProcessed");
    }
  }
}

const queue = new QueueSystem();

queue.on("taskAdded", (task) => {
  console.log(`Tarefa adicionada: ${task}`);
  console.log(queue.process);
});

queue.on("taskProcessed", (task) => {
  console.log(`Tarefa processada: ${task}`);
  console.log(queue.process);
});

queue.on("allTasksProcessed", () => {
  console.log("Todas as tarefas foram processadas!");
  console.log(queue.process);
});

queue.addToList("Enviar Email");
queue.addToList("Gerar relatório");
queue.addToList("Adicionar dados ao Banco de Dados");
