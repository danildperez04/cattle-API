const getUsers = (req, res) => {
    res.json({users : 'All users'});
  };
  
  const createUser = (req, res) => {
    res.send('User Created Succesfully');
  };
  
  const getSingleUser = (req, res) => {
    res.send(`Obtained user: ${req.params.id}`);
  };
  
  const updateUser = (req, res) => {
    res.send(`Updated User: ${req.params.id}`);
  };
  
  const deleteUser = (req, res) => {
    res.send(`Deleted User: ${req.params.id}`);
  };
  
  module.exports = {
    getUsers,
    createUser,
    getSingleUser,
    updateUser,
    deleteUser
  };

