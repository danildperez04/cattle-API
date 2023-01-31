import { useEffect } from "react";

function App() {
  
  useEffect(() => {
    function fetchData(){
      fetch("http://localhost:3001/api/v1/users")
      .then((response) => response.json())
      .then((response) => console.log(response))
      .catch((err) => console.error(err));
    }
    fetchData()
  }, []);
  return <h1>Hello world</h1>;
}
export default App;
