import 'package:client_flutter/pages/HomeMap.dart';
import 'package:client_flutter/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TagProvider(),
        child: MaterialApp(
          home: HomeMap(),
        ));
  }
}
