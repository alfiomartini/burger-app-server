import { Pool, RowDataPacket } from "mysql2/promise";
import { Request, Response } from "express";
import { Ingredient, WeakIngredient } from "../interfaces/types";
export const getAllIngredients =
  (connection: Pool) => async (req: Request, res: Response) => {
    try {
      const [results] = await connection.query<RowDataPacket[]>(
        "select * from ingredient"
      );
      if (Array.isArray(results)) {
        const normalized: Ingredient[] = results.map((item) => ({
          name: item.name,
          quantity: item.quantity,
          description: item.description,
          id: item.ing_id,
        }));
        res.status(200).json(normalized);
      } else {
        res.status(500).send("Internal server error");
      }
    } catch (error) {
      console.log("get all ingredients", error);
      res.status(500).send("Internal server error");
    }
  };

export const postIngredient =
  (connection: Pool) => async (req: Request, res: Response) => {
    try {
      const { name, quantity, description }: Ingredient = req.body;
      const [results] = (await connection.query(
        `insert into ingredient (name, quantity, description)
       values(?,?,?)`,
        [name, quantity, description]
      )) as any;
      res
        .status(201)
        .json({ id: results.insertId, name, quantity, description });
    } catch (error) {
      console.log("post ingredient", error);
      res.status(500).send("Internal server error");
    }
  };

export const getIngredientId =
  (connection: Pool) => async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const [results] = (await connection.query(
        "select * from ingredient where ing_id = ?",
        [id]
      )) as any;
      // test if results is not empty
      const {
        id: ing_id,
        quantity,
        description,
        name,
      }: Ingredient = results[0];
      res.status(200).json({ id, name, quantity, description });
    } catch (error) {
      console.log("get ingredient/id", error);
      res.status(500).send("Internal server error");
    }
  };

export const deleteIngredientId =
  (connection: Pool) => async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const [results] = await connection.query(
        "delete from ingredient where ing_id = ?",
        [id]
      );
      // test if results is not empty
      res.status(200).send(`Record successfully deleted`);
    } catch (error) {
      console.log("delete ingredient/id", error);
      res.status(500).send("Internal server error");
    }
  };

export const patchIngredientId =
  (connection: Pool) => async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const { name, quantity, description }: WeakIngredient = req.body;
      const [results] = await connection.query(
        `update ingredient 
        set name=?, quantity = ?, description=?
        where ing_id = ?`,
        [name, quantity, description, id]
      );
      res.status(200).json({ id, name, quantity, description });
    } catch (error) {
      console.log("patch ingredient/id", error);
    }
  };
