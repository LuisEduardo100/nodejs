import { Router } from "express";
//import { randomUUID} from 'node:crypto';
import { v4 as uuidv4 } from "uuid";
import { save } from "../database/database-functions.js";
import { driversOrdered, driversInRandomOrder } from "../database/script.js";
import {
  validateDriverInfo,
  validateUpdateDriverInfo,
  validatePosition,
} from "../utils/inputValidation.js";

const router = Router();
const dbDrivers = [...driversInRandomOrder];

router.get("/", (req, res) => {
  res.status(200).send(driversOrdered);
});

router.get("/standing/:position", (req, res, next) => {
  const { position } = req.params;
  const { error } = validatePosition(position, dbDrivers.length);

  if (error) {
    const err = new Error();
    err.statusCode = 400;
    err.description = error.details.map((e) =>
      e.message.replace(/["\\:]/g, "")
    );
    return next(err);
  }

  // if (error) {
  //   return res.status(400).json({
  //     message: "Validation error",
  //     details: error.details.map((e) => e.message.replace(/["\\:]/g, "")),
  //   });
  // }

  // if (!position || isNaN(position)) {
  //   return res.status(400).send("Invalid position");
  // }

  // if (position < 1 || position > dbDrivers.length) {
  //   return res.status(400).send("Invalid position");
  // }

  const driver = driversOrdered[position - 1];

  res.status(200).send(driver);
});

router.get("/:id", (req, res, next) => {
  const { id } = req.params;
  const driver = driversOrdered.find((d) => d.id === id);

  if (!driver) {
    const err = new Error();
    err.statusCode = 404;
    err.description = "Driver not found";
    return next(err);
  }

  res.status(200).send(driver);
});

router.post("/", (req, res, next) => {
  const { error } = validateDriverInfo(req.body);
  const { name, team, points } = req.body;

  if (error) {
    const err = new Error();
    err.statusCode = 400;
    err.description = error.details.map((e) =>
      e.message.replace(/["\\:]/g, "")
    );
    return next(err);
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

router.put("/:id", (req, res, next) => {
  const { error } = validateUpdateDriverInfo(req.body);

  if (error) {
    const err = new Error();
    err.statusCode = 400;
    err.description = error.details.map((e) =>
      e.message.replace(/["\\:]/g, "")
    );
    return next(err);
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

router.delete("/:id", (req, res) => {
  const { id } = req.params;
  const index = dbDrivers.findIndex((driver) => driver.id === id);

  if (index === -1) {
    const err = new Error();
    err.statusCode = 404;
    err.description = "Driver not found";
    return next(err);
  }

  dbDrivers.splice(index, 1);
  save(dbDrivers);

  res.status(204).send();
});

export default router;
