import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/HomePage.dart';
import './screens/InfoScreen.dart';
import './screens/TeamScreen.dart';
import './screens/AchievementPage.dart';
import './screens/ProjectScreen.dart';
import './screens/AuthScreen.dart';
import './screens/ChatScreen.dart';
import './screens/ChoiceScreen.dart';
import 'package:splashscreen/splashscreen.dart';
import './providers/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Data();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZINE',
        routes: {
          InfoScreen.route: (ctx) => InfoScreen(),
          TeamScreen.route: (ctx) => TeamScreen(),
          AchievementPage.route: (ctx) => AchievementPage(),
          ProjectScreen.route: (ctx) => ProjectScreen(),
          HomePage.route: (ctx) => HomePage(),
          AuthScreen.route: (ctx) => AuthScreen(),
          ChatScreen.route: (ctx) => ChatScreen(),
          ChoiceScreen.route: (ctx) => ChoiceScreen()
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: FutureBuilder(
          future: SharedPreferences.getInstance().then(
            (value) => value.getString("token"),
          ),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snap.hasData) {
              return HomePage();
            }
            return ChoiceScreen();
          }),
      image: Image.asset(
        "assets/images/zine-app.gif",
      ),
      loaderColor: Colors.blue[800],
      backgroundColor: Colors.white,
      photoSize: MediaQuery.of(context).size.height * 0.45,
      useLoader: false,
    );
  }
}
