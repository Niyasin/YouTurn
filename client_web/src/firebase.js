import firebase from 'firebase';

const firebaseConfig = {
  apiKey: "AIzaSyDjF1aXoqdTUUTHEcYW_lEXE10M1UPA9G8",
  authDomain: "cdns-fb325.firebaseapp.com",
  projectId: "cdns-fb325",
  storageBucket: "cdns-fb325.appspot.com",
  messagingSenderId: "577213484188",
  appId: "1:577213484188:web:3eb3d370c9d8609000b159",
  measurementId: "G-VK34QVYZX1"
};

    
firebase.initializeApp(firebaseConfig);
var auth = firebase.auth();

export {firebase,auth}