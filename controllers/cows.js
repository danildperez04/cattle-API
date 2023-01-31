const pool = require("../db.js");

const getCows = async (req, res) => {
  try {
    const [results] = await pool.query('CALL GET_COWS()');
    res.json({ results });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const createCow = async (req, res) => {
  const cow = req.body;

  try {
    const [results] = await pool.query(
      `CALL CREATE_COW({}{}{}{}{}{}{}{})`
    );

    res.status(201).send({ message: "Usuario creado exitosamente" });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: "Error al crear usuario" });
  }
};

const getSingleCow = async (req, res) => {
  try{
    const  [results]  = await pool.query(`CALL GET_COW(${req.params.id})`);
    res.json({ results });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
  
};

const updateCow = (req, res) => {
  res.send(`Updated Cow: ${req.params.id}`);
};

const deleteCow = (req, res) => {
  res.send(`Deleted Cow: ${req.params.id}`);
};

module.exports = {
  getCows,
  createCow,
  getSingleCow,
  updateCow,
  deleteCow,
};
