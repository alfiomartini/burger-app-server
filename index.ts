import express, { Request, Response } from "express";
import cors from "cors";
import bodyParser from "body-parser";
import ingredientRoutes from "./routes/ingredients";

const app = express();
const PORT = process.env.PORT || 5500;

app.use(cors());

app.use(bodyParser.json());

app.use("/ingredient", ingredientRoutes);

app.get("/", (req: Request, res: Response) =>
  res.send("Welcome to the Burger App API")
);
app.all("*", (req: Request, res: Response) =>
  res.send("You have tried reaching a route that does not exist")
);

app.listen(PORT, () =>
  console.log(`Server running on port: http://localhost:${PORT}`)
);
