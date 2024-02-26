import express from "express";

const router = express.Router();

router.get("/", (req, res) => {
  res.send("Return all ingredients");
});

router.post("/", (req, res) => {
  const { name, quantity, description } = req.body;
  res.json({ name, quantity, description });
});

router.get("/:id", (req, res) => {
  const { id } = req.params;
  res.json({ id });
});

router.delete("/:id", (req, res) => {
  const { id } = req.params;
  res.json({ id });
});

router.patch("/:id", (req, res) => {
  const { id } = req.params;
  res.json({ id });
});

export default router;
