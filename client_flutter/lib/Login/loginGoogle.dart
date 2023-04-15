import 'package:client_flutter/HomeMap.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Provider/Provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late GoogleSignInAccount _userObj;

  @override
  Widget build(BuildContext context) {
    var tagProvider_1 = Provider.of<TagProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 50, right: 50),
            child: Image.asset("assets/images/3.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: 50, right: 50, top: 15, bottom: 15)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: MaterialStateProperty.all(Size(200, 50)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
                onPressed: () {
                  if (tagProvider_1.getIsLoggedIn) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeMap(),
                        ));
                  } else {
                    _googleSignIn.signIn().then((userData) {
                      tagProvider_1.changeLogin();

                      if (tagProvider_1.getIsLoggedIn == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeMap(),
                            ));
                      }
                      _userObj = userData!;
                    }).catchError((e) {
                      print(e);
                    });
                  }
                },
                child: Text("Login with Google")),
          ),
        ],
      ),
    );
  }
}