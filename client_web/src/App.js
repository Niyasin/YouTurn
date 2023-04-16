import {MapContainer,TileLayer,Marker,Circle,useMapEvent,useMap} from 'react-leaflet'
import L, { point } from 'leaflet'
import {useEffect,useState} from 'react'
import Sidepanel from './components/Sidepanel';
import Nav from './components/Nav';
import AddPopup from './components/AddPopup';
import Login from './components/Login';
import {auth,firebase} from './firebase'



function App() {
  const [center,setCenter]=useState([11.833261768039069,75.9700440221417]);
  const [markers,setMarkers]=useState([]);
  const [selected,setSelected]=useState(null);
  const [addpopup,setAddPopup]=useState(false);
  const [Point,setPoint]=useState(null);
  const [loginPopup,setLoginPopup]=useState(false);
  const [user,setUser]=useState(null);

  const [admin,setAdmin]=useState(false);
  
  useEffect(()=>{
    if(user){
      auth.currentUser.getIdToken().then((token)=>{
        let xhr = new XMLHttpRequest();
        xhr.open('POST','/admin');
        xhr.setRequestHeader('Content-Type','application/json');
        xhr.send(JSON.stringify({
          token
        }));
        xhr.onload=()=>{
          if(xhr.responseText){
            let res=JSON.parse(xhr.responseText);
            if(res.status){
              setAdmin(true);
            }
          }
        }
        
      });
    }
  },[user]);


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

const gotoCurrent=()=>{
  if(navigator.geolocation){
    navigator.geolocation.getCurrentPosition(P=>{
      setCenter([P.coords.latitude,P.coords.longitude]);
    });
  }
}

  const loadData=(coords)=>{
      let xhr =new XMLHttpRequest();
      xhr.open('GET',`/getdata?lat=${coords[0]}&lng=${coords[1]}&range=5000000`);
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
    :<>
    <Map center={[]} markers={markers} selected={selected} setSelected={setSelected} setPoint={setPoint} Point={Point} setAddPopup={setAddPopup}/>
    </>}
    {selected?
      <Sidepanel data={selected} close={()=>{setSelected(null)}} reload={()=>{loadData(center)}} admin={admin}/>
      :<>
    <div className="loading"></div>
    </>}
    <Nav setAddPopup={setAddPopup} setLoginPopup={setLoginPopup} setSelected={setSelected} refresh={()=>{loadData(center)}} gotoCurrent={gotoCurrent} user={user} admin={admin} logout={()=>{auth.signOut();setUser(null);setAdmin(null)}}/>
    {addpopup?<AddPopup close={()=>{setAddPopup(false)}} Point={Point} reload={()=>{loadData(center)}}/>:<></>}
    {loginPopup?<Login close={()=>{setLoginPopup(false)}} onlogin={setUser} />:<></>}
    </div>
  );
}

export default App;


const Map = ({center,markers,setSelected,selected,setPoint,Point,setAddPopup})=>{

  function ChangeView({center}) {
    const map = useMap();
    map.setView(center, map.getZoom());
    return null;
  }
  useEffect(()=>{
  },[center]);
  return(
      <MapContainer  center={center} zoom={40} scrollWheelZoom={true} onClick={()=>{console.log("🍭");}}>
        <ChangeView center={center} zoom={40}/>
        <TileLayer url='https://tile.openstreetmap.org/{z}/{x}/{y}.png' />
        <Marker position={center}  icon={L.icon({ iconUrl:`./icons/current.png`, iconSize:[20,20]}) }/>
        {Point?<Marker position={Point} eventHandlers={{click:()=>{setAddPopup(true);}}} icon={L.icon({ iconUrl:`./icons/main.png`, iconSize:[30,30]}) }/>:<></>}
        {markers.map((m,i)=>{
          return(<>
                  <Marker 
                      key ={i} 
                      position={m.coordinates} 
                      eventHandlers={{click:()=>{setSelected(m);}}} 
                      icon={L.icon({
                        iconUrl:`./icons/${m.type.replace(' ','_')}.png`,
                        iconSize:[30,30]})
                        }
                  />
                  <Circle center={m.coordinates} radius={m.range || 100} fillColor={
                    m.type=='Tiger'?'#e6790d':(
                      m.type=='Flood'?'#2b76d2':'#ff0000'
                    )
                  } stroke={false}/>
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