import {MapContainer,TileLayer,Marker} from 'react-leaflet'
import {useEffect,useState} from 'react'
function App() {
  const [center,setCenter]=useState(null);
  const [markers,setMarkers]=useState([]);
  useEffect(()=>{
    if(navigator.geolocation){
      navigator.geolocation.getCurrentPosition(P=>{
        setCenter([P.coords.latitude,P.coords.longitude]);
        console.log(P.coords);
      })
    }
  },[])
  return (
    <div className="App">
    {center?
      <MapContainer  center={center} zoom={20}>
        <TileLayer url='https://tile.openstreetmap.org/{z}/{x}/{y}.png' attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'/>
      </MapContainer>
    :<></>}
    </div>
  );
}

export default App;
