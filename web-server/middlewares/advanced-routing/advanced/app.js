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

function errorHandler(err, req, res, next) {
  console.error(err);
  res.status(500).json({ message: "Erro interno do servidor" });
}

function authMiddleware(req, res, next) {
  const token = req.headers.authorization;
  if (!token || token !== "seu-token-seguro") {
    return res.status(401).json({ error: "Não autorizado" });
  }
  next();
}

function logger(req, res, next) {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
}
