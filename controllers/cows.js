const getCows = (req, res) => {
  res.send('Get All Cows');
};

const createCow = (req, res) => {
  res.send('Cow Created Succesfully');
};

const getSingleCow = (req, res) => {
  res.send(`Obtained Cow: ${req.params.id}`);
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
