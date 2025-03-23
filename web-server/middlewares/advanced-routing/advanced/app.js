import express from "express";
import usersRouter from "./routes/users.js";
import postsRouter from "./routes/posts.js";

const app = express();

app.use(registerRequest);
app.use(registerOnDatabase);
app.use(express.json());
app.use("/users", usersRouter);
app.use("/posts", postsRouter);

app.get("/", (req, res) => {
  res.status(200).send("Olá, Impressionador!");
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
