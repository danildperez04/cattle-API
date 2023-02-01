import axios from 'axios';
const baseUrl = 'http://localhost:3000/api/v1';

const getCows = ()=> {
  return axios.get(`${baseUrl}/cows`).then(response => response.data);
}

export default {
  getCows
}