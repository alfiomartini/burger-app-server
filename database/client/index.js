import express from "express";
import mysql from "mysql2/promise";
import "dotenv/config";

const connection = await mysql.createConnection({
  host: "localhost",
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PWD,
  database: "burger_app",
});

export { connection };
