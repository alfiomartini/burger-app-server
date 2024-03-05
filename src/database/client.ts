import mysql, { PoolOptions } from "mysql2/promise";
import "dotenv/config";

// Create the connection pool. The pool-specific settings are the defaults
const PORT = process.env.MYSQL_PORT as number | undefined;
const access: PoolOptions = {
  host: "mysql-db",
  user: process.env.MYSQL_USER,
  database: process.env.MYSQL_DB,
  password: process.env.MYSQL_PWD,
  waitForConnections: true,
  connectionLimit: 10,
  maxIdle: 10, // max idle connections, the default value is the same as `connectionLimit`
  idleTimeout: 60000, // idle connections timeout, in milliseconds, the default value 60000
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
};
const pool = mysql.createPool(access);

export { pool as connection };
