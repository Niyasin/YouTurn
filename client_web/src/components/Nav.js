export default function Nav({setAddPopup}){
    return(
        <div className="nav">
            <span>Home</span>
            <span onClick={()=>{setAddPopup(true)}}>Add Data</span>
            <span>Search</span>
            <span>Settings</span>
        </div>
    )
}