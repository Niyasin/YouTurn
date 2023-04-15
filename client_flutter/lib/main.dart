
import 'package:client_flutter/Login/loginGoogle.dart';
import 'package:client_flutter/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TagProvider_1(),
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: loginPage()));
  }
}