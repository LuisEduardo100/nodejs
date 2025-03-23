import express from "express";
import { posts } from "./data.js";

const app = express();

app.use(registerRequest);
app.use(registerOnDatabase);

app.get("/", (req, res) => {
  res.status(200).send("Olá, Impressionador!");
});

app.get("/posts", (req, res) => {
  //todo um processamento antes de entregar a resposta
  res.status(200).send(posts);
});

app.listen(5000, () => console.log("api rodando com sucesso"));

function registerRequest(req, res, next) {
  console.log("Nova solicitação http");
  console.log("Endpoint solicitado: ", req.url);
  next();
}

function registerOnDatabase(req, res, next) {
  console.log("Acessando o banco de dados");
  console.log("Registrando transação");
  next();
}
