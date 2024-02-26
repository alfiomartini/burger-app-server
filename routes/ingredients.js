import express from "express";
import mysql from "mysql2/promise";

const connection = await mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "burger_app",
});

const router = express.Router();

router.get("/", async (req, res) => {
  try {
    const [results] = await connection.query("select * from ingredient");
    console.log("results", results);
    res.status(200).json(results);
  } catch (error) {
    console.log("get all ingredients", error);
    res.status(500).send("Internal server error");
  }
});

router.post("/", async (req, res) => {
  const { name, quantity, description } = req.body;
  try {
    const [results] = await connection.query(
      `insert into ingredient (name, quantity, description)
       values(?,?,?)`,
      [name, quantity, description]
    );
    res
      .status(201)
      .json({ ing_id: results.insertId, name, quantity, description });
  } catch (error) {
    console.log("post ingredient", error);
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const [results] = await connection.query(
      "select * from ingredient where ing_id = ?",
      [id]
    );
    console.log("results", results);
    // test if results is not empty
    res.status(200).json(results[0]);
  } catch (error) {
    console.log("get ingredient/id", error);
    res.status(500).send("Internal server error");
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const [results] = await connection.query(
      "delete from ingredient where ing_id = ?",
      [id]
    );
    console.log("results", results);
    // test if results is not empty
    res.status(200).send(`Record successfully deleted`);
  } catch (error) {
    console.log("delete ingredient/id", error);
    res.status(500).send("Internal server error");
  }
});

router.patch("/:id", async (req, res) => {
  const { id, name, quantity, description } = req.body;
  try {
    const [results] = await connection.query(
      `update ingredient 
       set name=?, quantity = ?, description=?
       where ing_id = ?`,
      [name, quantity, description, id]
    );
    res.status(200).send("Record successfully updated");
  } catch (error) {
    console.log("patch ingredient/id", error);
  }
});

export default router;
