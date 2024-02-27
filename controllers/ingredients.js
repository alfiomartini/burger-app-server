export const getAllIngredients = (connection) => async (req, res) => {
  try {
    const [results] = await connection.query("select * from ingredient");
    res.status(200).json(results);
  } catch (error) {
    console.log("get all ingredients", error);
    res.status(500).send("Internal server error");
  }
};

export const postIngredient = (connection) => async (req, res) => {
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
    res.status(500).send("Internal server error");
  }
};

export const getIngredientId = (connection) => async (req, res) => {
  const { id } = req.params;
  try {
    const [results] = await connection.query(
      "select * from ingredient where ing_id = ?",
      [id]
    );
    // test if results is not empty
    res.status(200).json(results[0]);
  } catch (error) {
    console.log("get ingredient/id", error);
    res.status(500).send("Internal server error");
  }
};

export const deleteIngredientId = (connection) => async (req, res) => {
  const { id } = req.params;
  try {
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

export const patchIngredientId = (connection) => async (req, res) => {
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
};
