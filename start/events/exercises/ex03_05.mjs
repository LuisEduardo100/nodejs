import { EventEmitter } from "node:events";

const emissor = new EventEmitter();

// Exercício 3: Crie uma classe chamada Conversa que herde de EventEmitter. A classe
// deve ter um método chamado enviarMensagem que emita o evento mensagemEnviada. O
// evento deve aceitar um argumento com a mensagem enviada e exibir no console quando a
// mensagem for enviada.
// Exercício 4: Modifique o código da classe Conversa para herdar a emissão de eventos e
// adicione um novo evento chamado mensagemRecebida. Ao receber a mensagem, exiba
// "Nova mensagem recebida!" e a própria mensagem.
// Exercício 5: Modifique o código da classe Conversa para adicionar dois ouvintes diferentes
// para o evento mensagemRecebida. O primeiro ouvinte deve exibir o conteúdo da mensagem,
// e o segundo ouvinte deve contar quantas mensagens foram recebidas.
class Conversa extends EventEmitter {
  constructor() {
    super();
    this.totalMensagens = 0;
  }

  enviarMensagem(msg) {
    this.emit("mensagemEnviada", msg);
  }

  receberMensagem(msg) {
    this.emit("mensagemRecebida", msg);
  }
}

const chat = new Conversa();

chat.on("mensagemEnviada", (msg) => {
  console.log(`Mensagem enviada: ${msg}`);
});

chat.on("mensagemRecebida", (msg) => {
  console.log(`Mensagem recebida: ${msg}`);
});

chat.on("mensagemRecebida", () => {
  chat.totalMensagens++;
  console.log(`Total de mensagens enviadas: ${chat.totalMensagens}`);
});

chat.receberMensagem("Mensagem recebida 1");
chat.receberMensagem("Mensagem recebida 2");
chat.receberMensagem("Mensagem recebida 3");
chat.receberMensagem("Mensagem recebida 4");
