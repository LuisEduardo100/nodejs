// Crie um sistema de login que herda de EventEmitter. O sistema deve emitir
// um evento loginAttempt toda vez que uma tentativa de login é feita. Se o usuário e senha
// forem corretos, emita o evento loginSuccess, caso contrário, loginFailure. Use um
// callback para simular uma operação assíncrona (como consultar um banco de dados) que leva

import { EventEmitter } from "node:events";

// 1 segundo
class LoginSystem extends EventEmitter {
  constructor() {
    super();
    this.email = "email123";
    this.password = "123";
  }

  handleLogin(email, password) {
    this.emit("loginAttempt", email);

    if (email !== this.email || password !== this.password) {
      setTimeout(() => {
        this.emit("loginFailure", email);
      }, 2000);
    } else {
      setTimeout(() => {
        this.emit("loginSuccess", email);
      }, 2000);
    }
  }
}

const login = new LoginSystem();

login.on("loginAttempt", (user) => {
  console.log(`Tentativa de login para o usuário: ${user}`);
});

login.on("loginSuccess", (user) => {
  console.log(`Login bem-sucedido: ${user}`);
});

login.on("loginFailure", (user) => {
  console.log(`Falha na tentativa de login do usuário: ${user}`);
});

login.handleLogin("email123", "123");
