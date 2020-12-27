import 'package:flutter/material.dart';
import './screens/HomePage.dart';
import './screens/InfoScreen.dart';
import './screens/TeamScreen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zine',
      routes: {
        InfoScreen.route: (ctx) => InfoScreen(),
        TeamScreen.route: (ctx) => TeamScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        seconds: 4,
        navigateAfterSeconds: HomePage(),
        image: Image.asset(
          "assets/images/image.png",
        ),
        backgroundColor: Colors.white,
        photoSize: 150,
        title: Text(
          "WHERE IMAGINATION LEADS TO CREATION",
          style: TextStyle(
            fontFamily: "Megatron",
            fontSize: 14,
            color: Colors.blue[800],
          ),
        ),
      ),
    );
  }
}
