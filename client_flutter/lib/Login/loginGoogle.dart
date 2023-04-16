import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../pages/HomeMap.dart';
import '../provider/tag_provider.dart';
import 'login_with_phone.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late GoogleSignInAccount _userObj;

  @override
  Widget build(BuildContext context) {
    var tagProvider = Provider.of<TagProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 50, right: 50),
                child: Image.asset("assets/images/3.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 50, right: 50, top: 15, bottom: 15)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginWithPhone(),
                          ));
                    },
                    child: const Text("Login with Phone")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 50, right: 50, top: 15, bottom: 15)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                    onPressed: () async {
                      if (tagProvider.getIsLoggedIn == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeMap(),
                            ));
                      } else {
                        await _googleSignIn.signIn().then((userData) {
                          _userObj = userData!;
                          tagProvider.changeLogin();
                          if (tagProvider.getIsLoggedIn == true) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeMap(),
                                ));
                          }
                        }).catchError((e) {
                          print(e);
                        });
                      }
                    },
                    child: const Text("Login with Google")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
