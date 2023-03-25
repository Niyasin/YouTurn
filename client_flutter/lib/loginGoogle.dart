import 'dart:js';

import 'package:client_flutter/HomeMap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

handleGoogleBtnClick() {
  signInWithGoogle().then((user) {
    Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => const HomeMap(),
        ));
  });
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(left: 50, right: 50, top: 15, bottom: 15)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.black),
              minimumSize: MaterialStateProperty.all(Size(200, 50)),
              textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
          onPressed: () {},
          child: Text("Login with Google")),
    );
  }
}
