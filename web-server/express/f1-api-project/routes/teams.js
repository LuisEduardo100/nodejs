import { Router } from "express";
import { validatePosition } from "../utils/inputValidation.js";
import { teams } from "../database/script.js";

const router = Router();

router.get("/", (req, res) => {
  res.status(200).send(teams);
});

router.get("/standing/:position", (req, res, next) => {
  const { position } = req.params;
  const { error } = validatePosition(position, teams.length);

  if (error) {
    const err = new Error();
    err.statusCode = 400;
    err.description = error.details.map((e) =>
      e.message.replace(/["\\:]/g, "")
    );
    return next(err);
  }

  const team = teams[position - 1];
  res.status(200).send(team);
});

export default router;
