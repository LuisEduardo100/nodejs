import { Router } from "express";
import { validatePosition } from "../utils/inputValidation.js";
import { teams } from "../database/script.js";

const router = Router();

router.get("/", (req, res) => {
  res.status(200).send(teams);
});

router.get("/standing/:position", (req, res) => {
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

export default router;
