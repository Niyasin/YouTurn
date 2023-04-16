var firebaseAdmin = require("firebase-admin");

firebaseAdmin.initializeApp({
  credential: firebaseAdmin.credential.cert(process.env.GOOGLE_APPLICATION_CREDENTIALS)
});

module.exports = firebaseAdmin