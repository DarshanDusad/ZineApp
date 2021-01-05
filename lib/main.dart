import 'package:flutter/material.dart';
import './screens/HomePage.dart';
import './screens/InfoScreen.dart';
import './screens/TeamScreen.dart';
import './screens/AchievementPage.dart';
import './screens/ProjectScreen.dart';
import './screens/AuthScreen.dart';
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
        TeamScreen.route: (ctx) => TeamScreen(),
        AchievementPage.route: (ctx) => AchievementPage(),
        ProjectScreen.route: (ctx) => ProjectScreen(),
        HomePage.route: (ctx) => HomePage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        seconds: 4,
        navigateAfterSeconds: AuthScreen(),
        image: Image.asset(
          "assets/images/Splash.gif",
        ),
        loaderColor: Colors.blue[800],
        backgroundColor: Colors.white,
        photoSize: 200,
        title: Text(
          "Where Imagination Leads To Creation",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
        ),
      ),
    );
  }
}
