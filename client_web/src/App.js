import {MapContainer,TileLayer,Marker,useMapEvent} from 'react-leaflet'
import {useEffect,useState} from 'react'
function App() {
  const [center,setCenter]=useState([11.833604756618415, 75.97033436271461]);
  const [markers,setMarkers]=useState([]);

  useEffect(()=>{
    if(navigator.geolocation){
      navigator.geolocation.getCurrentPosition(P=>{
        setCenter([P.coords.latitude,P.coords.longitude]);
      });
    }
  },[]);
  
  useEffect(()=>{
    if(center){
      loadData(center);
    }
  },[center])

  const loadData=(coords)=>{
      let xhr =new XMLHttpRequest();
      xhr.open('GET',`/loaddata?lat=${coords[0]}&lng=${coords[1]}&range=5000`);
      xhr.send();
      xhr.onload=()=>{
        let data = JSON.parse(xhr.responseText);
        if(data){
          setMarkers(data);
        }
      }
    }
    
  return (
    <div className="App">
    {center?
      <MapContainer  center={center} zoom={25} scrollWheelZoom={true} >
        <TileLayer url='https://tile.openstreetmap.org/{z}/{x}/{y}.png' attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'/>
        {markers.map(m=>{
          return(<Marker position={m.coordinates} eventHandlers={{click:()=>{console.log("HELLO");}}}/>);
        })}
      </MapContainer>
    :<></>}
    </div>
  );
}

export default App;
