import {useEffect,useState} from 'react'
import {auth,firebase} from '../firebase'

export default function Login({close,onlogin}){
    const [phoneNumber, setPhoneNumber] = useState('+919946853725');
    const [verificationCode, setVerificationCode] = useState('123456');
    const [verification,setVerification]=useState(false);
    const [final,setFinal]=useState(null);
    const [signup,setSignup]=useState(false);
    const [name,setName]=useState(null);
    const [email,setEmail]=useState(null);
    const [user,setUser]=useState(null);

    const signin = () => {
    
        let verify = new firebase.auth.RecaptchaVerifier('recaptcha-container');
        auth.signInWithPhoneNumber(phoneNumber, verify).then((result) => {
            setFinal(result);
            setVerification(true);
        })
            .catch((err) => {
                

            });
    }
  
    // Validate OTP
    const ValidateOtp = () => {
        if (verificationCode === null || final === null)
            return;
        final.confirm(verificationCode).then((result) => {
            console.log(result);
            if(result.additionalUserInfo.isNewUser){
                setSignup(true);
            }else{
                close();
                onlogin(result.user);
            }
            setUser(result.user)
        }).catch((err) => {

        })
    }

    const updateUser = async()=>{
                user.updateProfile({
                    email:email,
                    displayName:name,
                }).then((result)=>{
                    onlogin(result.user);
                    setUser(result.user);
                })

    }
return(
        <div className="login">
            {verification?<>
            {signup?<>
                <input placeholder="Name" onChange={(e)=>{setName(e.target.value)}}/>
                <input placeholder="Email" onChange={(e)=>{setEmail(e.target.value)}}/>
                <div className="btngrp">
                    <div className="button verified" onClick={()=>{updateUser()}}>Submit</div>
                    <div className="button" onClick={close}>Cancel</div>
                </div>
            </>:<>
            <h1>verify OTP</h1>
                <input placeholder="verification code" onChange={(e)=>{setVerificationCode(e.target.value)}}/>
                <div className="btngrp">
                <div className="button verified" onClick={()=>{ValidateOtp()}}>Verify</div>
                <div className="button" onClick={close}>Cancel</div>
            </div>
            </>}
            </>:<>
            <h1>Signin</h1>
                <input placeholder="phone number" onChange={(e)=>{setPhoneNumber(e.target.value)}}/>
                <div id="recaptcha-container"></div>
                <div className="btngrp">
                    <div className="button verified" onClick={()=>{signin()}}>Login</div>
                    <div className="button" onClick={close}>Cancel</div>
                </div>
            </>}
        </div>
)
}

