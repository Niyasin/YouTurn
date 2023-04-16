export default function Nav({setAddPopup,gotoCurrent,refresh,setLoginPopup,user,admin,logout}){
    return(
        <div className="nav">
            <div className="left">
                <span>Home</span>
                <span onClick={()=>{setAddPopup(true)}}>Add Data</span>
                <span>Search</span>
                <span>Settings</span>

                    <div className="iconbtn" onClick={refresh}>
                    <svg viewBox="0 0 24 24"><path d="M19.91 15.51h-4.53a1 1 0 0 0 0 2h2.4A8 8 0 0 1 4 12a1 1 0 0 0-2 0 10 10 0 0 0 16.88 7.23V21a1 1 0 0 0 2 0v-4.5a1 1 0 0 0-.97-.99ZM15 12a3 3 0 1 0-3 3 3 3 0 0 0 3-3Zm-4 0a1 1 0 1 1 1 1 1 1 0 0 1-1-1Zm1-10a10 10 0 0 0-6.88 2.77V3a1 1 0 0 0-2 0v4.5a1 1 0 0 0 1 1h4.5a1 1 0 0 0 0-2h-2.4A8 8 0 0 1 20 12a1 1 0 0 0 2 0A10 10 0 0 0 12 2Z"/></svg>
                    </div>

                    <div className="iconbtn" onClick={gotoCurrent}>
                    <svg viewBox="0 0 24 24"><path fill-rule="evenodd" d="M3.055 13H1v-2h2.055A9.004 9.004 0 0 1 11 3.055V1h2v2.055A9.004 9.004 0 0 1 20.945 11H23v2h-2.055A9.004 9.004 0 0 1 13 20.945V23h-2v-2.055A9.004 9.004 0 0 1 3.055 13ZM12 5a7 7 0 1 0 0 14 7 7 0 0 0 0-14Zm0 3a4 4 0 1 1 0 8 4 4 0 0 1 0-8Zm0 2a2 2 0 1 0 0 4 2 2 0 0 0 0-4Z"/></svg>
                </div>
            </div>
                <div className="right">
                    {user?<>
                        <div className="button" onClick={logout}>Signout</div>
                        <span>{user.displayName}</span>
                    </>
                    :
                    <div className="button" onClick={()=>{setLoginPopup(true)}}>Signin</div>
                    }
                </div>
        </div>
    )
}