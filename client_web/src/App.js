import {MapContainer,TileLayer,Marker,Circle} from 'react-leaflet'
import L from 'leaflet'
import {useEffect,useState} from 'react'
import Sidepanel from './components/Sidepanel';
function App() {
  const [center,setCenter]=useState(null);
  const [markers,setMarkers]=useState([]);
  const [selected,setSelected]=useState(null);

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
      <Map center={center} markers={markers} selected={selected} setSelected={setSelected}/>
    :<></>}
    {selected?
      <Sidepanel data={selected} close={()=>{setSelected(null)}}/>
    :<></>}
    </div>
  );
}

export default App;


const Map = ({center,markers,setSelected,selected})=>{


  return(
      <MapContainer  center={[11.833272071120348, 75.9702383854215]} zoom={25} scrollWheelZoom={true} >
        <TileLayer url='https://tile.openstreetmap.org/{z}/{x}/{y}.png' attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'/>
        {markers.map((m,i)=>{
          return(<>
                  <Marker 
                      key ={i} 
                      position={m.coordinates} 
                      eventHandlers={{click:()=>{setSelected(m);}}} 
                      icon={L.icon({
                        iconUrl:`./icons/${m.type}.png`,
                        iconSize:[30,30]})
                        }
                  />
                  <Circle center={m.coordinates} radius={m.range || 100} fillColor="#ff0000" stroke={false}/>
                </>
                  );
        })}
      </MapContainer>
  )
}