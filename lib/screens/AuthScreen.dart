import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:zine/widgets/signInForm.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return FlutterLogin(
      emailValidator: (value) {
        if (value.isEmpty) {
          return "Please enter a valid college email address";
        }
        if (value.startsWith("2020") &&
            (value.endsWith("@mnit.ac.in") ||
                value.endsWith("@iiitkota.ac.in"))) {
          return null;
        }
        return "Please enter a valid college email address";
      },
      passwordValidator: (value) {
        if (value.isEmpty || value.length < 6) {
          return "Please enter a password of atleast 6 characters";
        }
        return null;
      },
      messages: LoginMessages(
          confirmPasswordError: "Passwords do not match",
          usernameHint: "College Email",
          loginButton: "Login",
          signupButton: "Sign Up"),
      theme: LoginTheme(
        primaryColor: Colors.blue[600],
        titleStyle: TextStyle(
          fontFamily: "Megatron",
          fontSize: 64,
        ),
        cardTheme: CardTheme(
          color: Colors.grey[200],
          elevation: 25,
        ),
        textFieldStyle: TextStyle(
          fontFamily: "OpenSans",
        ),
        afterHeroFontSize: orientation == Orientation.portrait ? 30 : 20,
        beforeHeroFontSize: 64,
      ),
      title: orientation == Orientation.portrait ? "ZINE" : "",
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed("/home");
      },
      titleTag: "h",
      onSignup: (data) async {
        var map = await showDialog(
          context: context,
          builder: (context) {
            return SignInForm();
          },
        );
        if (map == null) {
          return Future.value("Please enter the required information");
        }
        http.Response response;
        try {
          print(
            {
              "fullName": map["name"],
              "email": data.name,
              "password": data.password,
              "rollNumber": data.name.endsWith("@mnit.ac.in")
                  ? data.name.substring(0, 11)
                  : data.name.substring(0, 12),
              "domainOfInterest": [map["domain"]]
            },
          );
          response = await http.post(
            "http://192.168.29.83:3000/api/signup",
            body: json.encode(
              {
                "fullName": map["name"],
                "email": data.name,
                "password": data.password,
                "rollNumber": data.name.endsWith("@mnit.ac.in")
                    ? data.name.substring(0, 11)
                    : data.name.substring(0, 12),
                "domainOfInterest": [map["domain"]]
              },
            ),
          );
        } catch (error) {
          print("hello");
          print(error.toString());
          return Future.value("An error occured");
        }
        print(json.decode(response.body));
        return null;
      },
      onLogin: (data) {
        return Future.delayed(Duration(milliseconds: 2500)).then((value) {
          return null;
        });
      },
      onRecoverPassword: (data) {
        return Future.value("Ainnnnnnnn");
      },
    );
  }
}
