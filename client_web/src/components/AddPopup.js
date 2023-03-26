import {useState} from 'react'
export default function AddPopup({close ,Point,reload}){
    const [type,setType] =useState('Road Block');
    const [desc,setDesc] =useState('');
    const [range,setRange] =useState(null);


    const add=()=>{
        if(Point){
            let xhr=new XMLHttpRequest();
            xhr.open('POST','/add');
            xhr.setRequestHeader('Content-Type','application/json');
            xhr.send(JSON.stringify({
                lat:Point[0],
                lon:Point[1],
                type:type,
                desc:desc,
                range:range || null,
            }));
            xhr.onload=()=>{
                close();
                reload();
            }
        }
    }

    return(
        <div className="addpopup">
            <div className="head">
                <h1>Add new</h1>
                <div className="iconbtn" onClick={close} ><svg viewBox="0 0 52 52"><path d="m31 25.4 13-13.1c.6-.6.6-1.5 0-2.1l-2-2.1c-.6-.6-1.5-.6-2.1 0L26.8 21.2c-.4.4-1 .4-1.4 0L12.3 8c-.6-.6-1.5-.6-2.1 0l-2.1 2.1c-.6.6-.6 1.5 0 2.1l13.1 13.1c.4.4.4 1 0 1.4L8 39.9c-.6.6-.6 1.5 0 2.1l2.1 2.1c.6.6 1.5.6 2.1 0L25.3 31c.4-.4 1-.4 1.4 0l13.1 13.1c.6.6 1.5.6 2.1 0L44 42c.6-.6.6-1.5 0-2.1L31 26.8c-.4-.4-.4-1 0-1.4z"/></svg></div>
            </div>
            <div className="content">
                    <select onChange={(e)=>{setType(e.target.value)}} defaultValue='Road Block'>
                        <option value="Road Block" selected>Road Block</option>
                        <option value="Landslide">Land Slide</option>
                        <option value="Flood">Flood</option>
                        <option value="Tiger">Tiger</option>
                        <option value="Downed powerline">Down Powerline</option>
                        <option value="Other">Other</option>
                    </select>
                    <span>{Point}</span>
                    <input type="number" step={10} defaultValue={null} onChange={(e)=>{setRange(Number(e.target.value))}}/>
                    <textarea placeholder="description" onChange={(e)=>{setDesc(e.target.value)}}/>

                    <div className="button verified wide">Add Photos</div>
                    <div className="button verified wide" onClick={add}>Submit</div>
        
            </div>
        </div>
    )
}