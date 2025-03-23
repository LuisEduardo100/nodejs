import express from "express";
//import { randomUUID} from 'node:crypto';
import { v4 as uuidv4 } from "uuid";
import { save } from "./database/database-functions.js";
import {
  driversInRandomOrder,
  driversOrdered,
  teams,
} from "./database/script.js";
import {
  validateDriverInfo,
  validatePosition,
  validateUpdateDriverInfo,
} from "./utils/inputValidation.js";

const app = express();
app.use(express.json());

const baseRoute = "/api/v1";
const dbDrivers = [...driversInRandomOrder];

// Rotas para as equipes

app.get(baseRoute + "/teams", (req, res) => {
  res.status(200).send(teams);
});

app.get(baseRoute + "/teams/standing/:position", (req, res) => {
  const { position } = req.params;
  const { error } = validatePosition(position, teams.length);

  if (error) {
    return res.status(400).json({
      message: "Validation error",
      details: error.details.map((e) => e.message.replace(/["\\:]/g, "")),
    });
  }

  const team = teams[position - 1];
  res.status(200).send(team);
});

// Rotas para os pilotos
app.get(baseRoute + "/drivers", (req, res) => {
  res.status(200).send(driversOrdered);
});

app.get(baseRoute + "/drivers/standing/:position", (req, res) => {
  const { position } = req.params;
  const { error } = validatePosition(position, dbDrivers.length);

  if (error) {
    return res.status(400).json({
      message: "Validation error",
      details: error.details.map((e) => e.message.replace(/["\\:]/g, "")),
    });
  }

  // if (!position || isNaN(position)) {
  //   return res.status(400).send("Invalid position");
  // }

  // if (position < 1 || position > dbDrivers.length) {
  //   return res.status(400).send("Invalid position");
  // }

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
  const { error } = validateDriverInfo(req.body);
  const { name, team, points } = req.body;

  if (error) {
    return res.status(400).json({
      message: "Validation error",
      details: error.details.map((e) => e.message.replace(/["\\:]/g, "")),
    });
  }

  // if (!name || !team || points === undefined) {
  //   return res
  //     .status(400)
  //     .send("Missing required fields: name, team, and points");
  // }

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

app.put(baseRoute + "/drivers/:id", (req, res) => {
  const { error } = validateUpdateDriverInfo(req.body);

  if (error) {
    return res.status(400).json({
      message: "Validation error",
      details: error.details.map((e) => e.message.replace(/["\\:]/g, "")),
    });
  }

  const { id } = req.params;

  const driver = driversOrdered.find((driver) => driver.id === id);

  if (!driver) {
    return res.status(404).send("Driver not found");
  }

  for (const key in driver) {
    if (req.body[key]) {
      driver[key] = req.body[key];
    }
  }

  save(dbDrivers);
  res.status(200).send(driver);
});

app.delete(baseRoute + "/drivers/:id", (req, res) => {
  const { id } = req.params;
  const index = dbDrivers.findIndex((driver) => driver.id === id);

  if (index === -1) {
    return res.status(404).send("Driver not found");
  }

  dbDrivers.splice(index, 1);
  save(dbDrivers);

  res.status(204).send();
});

const port = 3000;
app.listen(3000, () => {
  console.log(`Server running on port ${3000}`);
});
