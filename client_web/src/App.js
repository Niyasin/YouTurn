import {MapContainer,TileLayer,Marker,Circle,useMapEvent} from 'react-leaflet'
import L, { point } from 'leaflet'
import {useEffect,useState} from 'react'
import Sidepanel from './components/Sidepanel';
import Nav from './components/Nav';
import AddPopup from './components/AddPopup';
function App() {
  const [center,setCenter]=useState(null);
  const [markers,setMarkers]=useState([]);
  const [selected,setSelected]=useState(null);
  const [addpopup,setAddPopup]=useState(false);
  const [Point,setPoint]=useState(null);

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
      xhr.open('GET',`/getdata?lat=${coords[0]}&lng=${coords[1]}&range=5000`);
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
      <Map center={center} markers={markers} selected={selected} setSelected={setSelected} setPoint={setPoint} Point={Point} setAddPopup={setAddPopup}/>
    :<></>}
    {selected?
      <Sidepanel data={selected} close={()=>{setSelected(null)}} reload={()=>{loadData(center)}}/>
    :<>
    <div className="loading"></div>
    </>}
    <Nav setAddPopup={setAddPopup}/>
    {addpopup?<AddPopup close={()=>{setAddPopup(false)}} Point={Point} reload={()=>{loadData(center)}}/>:<></>}
    </div>
  );
}

export default App;


const Map = ({center,markers,setSelected,selected,setPoint,Point,setAddPopup})=>{
  
  return(
      <MapContainer  center={[11.833272071120348, 75.9702383854215]} zoom={25} scrollWheelZoom={true} onClick={()=>{console.log("🍭");}}>
        <TileLayer url='https://tile.openstreetmap.org/{z}/{x}/{y}.png' 
        eventHandlers={{click:()=>{console.log("🍭");}}}
        />
        {Point?<Marker position={Point} eventHandlers={{click:()=>{setAddPopup(true);}}} icon={L.icon({ iconUrl:`./icons/main.png`, iconSize:[30,30]}) }/>:<></>}
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
        <Pointer setPoint={setPoint}/>
      </MapContainer>
  )
}


function Pointer({setPoint}) {
  const map = useMapEvent('click', (e) => {
    setPoint([e.latlng.lat,e.latlng.lng]);
  })
  return null
}