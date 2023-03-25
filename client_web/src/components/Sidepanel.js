export default function Sidepanel({data,close}){
    return(
        <div className="sidepanel">
            <div className="head">
            <h1>{data.type}</h1>
            <div className="iconbtn" onClick={close} ><svg viewBox="0 0 52 52"><path d="m31 25.4 13-13.1c.6-.6.6-1.5 0-2.1l-2-2.1c-.6-.6-1.5-.6-2.1 0L26.8 21.2c-.4.4-1 .4-1.4 0L12.3 8c-.6-.6-1.5-.6-2.1 0l-2.1 2.1c-.6.6-.6 1.5 0 2.1l13.1 13.1c.4.4.4 1 0 1.4L8 39.9c-.6.6-.6 1.5 0 2.1l2.1 2.1c.6.6 1.5.6 2.1 0L25.3 31c.4-.4 1-.4 1.4 0l13.1 13.1c.6.6 1.5.6 2.1 0L44 42c.6-.6.6-1.5 0-2.1L31 26.8c-.4-.4-.4-1 0-1.4z"/></svg></div>
            </div>
            <div className="content">
                <div className="box">
                    <h2>Posted At</h2>
                    <span>{data.date.split("T")[0]}</span>
                    <span>{data.date.split("T")[1]}</span>
                    <div className="btngrp">
                        {data.verified?<div className="button verified">Verified</div>:<div className="button">Verify</div>}
                        {data.status?<div className="button">Enable</div>:<div className="button verified">Disable</div>}
                    </div>
                </div>

                <div className="box">
                    <h2>Expires </h2>
                    <span>{data.expires.split("T")[0]}</span>
                    <span>{data.expires.split("T")[1]}</span>
                </div>


            <div className="photos">
                {data.photos.map(e=>{
                    <img src={e}/>
                })}
            </div>
            </div>

        </div>
    )
}