import express from "express";
import helmet from "helmet";
import driversRouter from "./routes/driver.js";
import teamsRouter from "./routes/teams.js";

const baseRoute = "/api/v1";

const app = express();

app.use(express.json());
app.use(helmet());
app.use(baseRoute + "/drivers", driversRouter);
app.use(baseRoute + "/teams", teamsRouter);
app.use((err, req, res, next) => {
  res.status(err.statusCode ?? 500).send(err);
});

const port = 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
