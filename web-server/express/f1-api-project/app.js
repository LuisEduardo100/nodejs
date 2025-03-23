import express from "express";
import { driversInRandomOrder, driversOrdered } from "./database/script.js";
//import { randomUUID} from 'node:crypto';
import { v4 as uuidv4 } from "uuid";
import { save } from "./database/database-functions.js";

const app = express();
app.use(express.json());

const baseRoute = "/api/v1";

const dbDrivers = [...driversInRandomOrder];
app.get(baseRoute + "/drivers", (req, res) => {
  res.status(200).send(driversOrdered);
});

app.get(baseRoute + "/drivers/standing/:position", (req, res) => {
  const { position } = req.params;
  const driver = driversOrdered[position - 1];
  res.status(200).send(driver);
});

app.get(baseRoute + "/drivers/:id", (req, res) => {
  const { id } = req.params;
  const driver = driversOrdered.find((d) => d.id === id);
  if (!driver) {
    return res.status(404).send("Driver not found");
  }
  res.status(200).send(driver);
});

app.post(baseRoute + "/drivers", (req, res) => {
  const { name, team, points } = req.body;
  if (!name || !team || !points) {
    return res
      .status(400)
      .send("Missing required fields: name, team, and points");
  }

  //newDriver = {...req.body, id: randomUUID()}
  const newDriver = {
    id: uuidv4(),
    name,
    team,
    points,
  };

  dbDrivers.push(newDriver);
  save(dbDrivers);
  res.status(201).send(newDriver);
});

const port = 3000;
app.listen(3000, () => {
  console.log(`Server running on port ${3000}`);
});
