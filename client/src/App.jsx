import { useEffect, useState } from 'react';
import cowsService from './services/cows';
import './App.css';

function App() {
  const [cows, setCows] = useState([]);
  // const [degrees, setDegrees] = useState({ x: 0, y: 0 });

  useEffect(() => {
    cowsService
      .getCows()
      .then((cows) => setCows(cows))
      .catch(console.log);
  }, []);

  // useEffect(() => {
  //   const root = document.querySelector('#root');
  //   const { width, height } = root.getBoundingClientRect();

  //   const halfWidth = width / 2;
  //   const halfHeight = height / 2;

  //   const handleMove = (e) => {
  //     const { clientX, clientY } = e;
  //     const rotationX = ((clientX - halfWidth) / halfWidth) * 10;
  //     const rotationY = ((clientY - halfHeight) / halfHeight) * 10;

  //     setDegrees({ x: rotationX, y: rotationY });
  //   };

  //   root.addEventListener('mousemove', handleMove);
  //   root.addEventListener('mouseleave', () => {
  //     setDegrees({ x: 0, y: 0 });
  //   });
  //   return () => {
  //     document.removeEventListener('mousemove', handleMove);
  //   };
  // }, []);

  return (
    <>
      <h1>Cows</h1>
      {cows.map(({ id_cow, cow_name, cow_desc, alive, gender }) => (
        <div
          className='cow-card'
          key={id_cow}
          // style={{
          //   transform: `rotateX(${degrees.x}deg) rotateY(${degrees.y}deg)`,
          // }}
        >
          <header
            className={`cow-card-header ${
              gender === 'MACHO' ? 'male' : 'female'
            }`}
          >
            <h3>{cow_name}</h3>
            <p>{gender}</p>
          </header>
          <span>{cow_desc}</span>
          <span>{alive ? 'Viva' : 'Muerta'}</span>
        </div>
      ))}
    </>
  );
}
export default App;
