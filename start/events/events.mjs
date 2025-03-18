import { EventEmitter } from "node:events";

function sendToBigCompanyTV(message) {
  console.log("---------------------------");
  console.log(message);
}

class CompanySales extends EventEmitter {
  performSale() {
    console.log("Registrando venda no banco de dados");
    super.emit("Venda realizada!");
  }
}

const sales = new CompanySales();

sales.on("Venda realizada!", () => {
  sendToBigCompanyTV("Mais uma venda realizada!");
});

sales.performSale();
