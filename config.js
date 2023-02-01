module.exports = (key) => {
  if(!configObj.hasOwnProperty(key)) throw new Error(`${key} is not a valid config key`);
  return configObj[key];
}

configObj = {
  db: {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    name: process.env.DB_NAME,
  },
  host: process.env.HOST,
  port: process.env.PORT,
};
