import express from "express";
import { drivers } from "./database/script.js";

const app = express();

const baseRoute = "/api/v1";

app.get(baseRoute + "/drivers", (req, res) => {
  res.status(200).send(drivers);
});

const port = 3000;
app.listen(3000, () => {
  console.log(`Server running on port ${3000}`);
});
