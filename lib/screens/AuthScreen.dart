import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:zine/widgets/signInForm.dart';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";
import 'package:provider/provider.dart';
import 'package:zine/providers/data.dart';

class AuthScreen extends StatefulWidget {
  static const route = "/auth";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isSignUp = false;

  Future<void> onLogin(Map<dynamic, dynamic> data) async {
    var ref = await SharedPreferences.getInstance();
    ref.setString("token", data["token"]);
    ref.setString("name", data["user"]["fullName"]);
    ref.setString("email", data["user"]["email"]);
    ref.setString("domain", (data["user"]["domainOfInterest"][0]));
    Provider.of<Data>(context, listen: false).addData(
        data["token"],
        data["user"]["fullName"],
        data["user"]["email"],
        (data["user"]["domainOfInterest"][0]));
  }

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
        if (_isSignUp) {
          Navigator.of(context).pushReplacementNamed("/auth");
        } else {
          Navigator.of(context).pushReplacementNamed("/home");
        }
      },
      titleTag: "h",
      onSignup: (data) async {
        _isSignUp = true;
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
          // print(
          //   {
          //     "fullName": map["name"],
          //     "email": data.name,
          //     "password": data.password,
          //     "rollNumber": data.name.endsWith("@mnit.ac.in")
          //         ? data.name.substring(0, 11)
          //         : data.name.substring(0, 12),
          //     "domainOfInterest": [map["domain"]],
          //     "college": data.name.endsWith("@mnit.ac.in") ? "MNIT" : "IIITK"
          //   },
          // );
          response = await http.post(
            "http://10.0.2.2:3000/api/signup",
            headers: {
              "content-type": "application/json",
            },
            body: json.encode(
              {
                "fullName": map["name"].toString(),
                "email": data.name,
                "password": data.password,
                "rollNumber": data.name.endsWith("@mnit.ac.in")
                    ? data.name.substring(0, 11)
                    : data.name.substring(0, 12),
                "domainOfInterest": [map["domain"].toString()],
                "college": data.name.endsWith("@mnit.ac.in") ? "MNIT" : "IIITK",
              },
            ),
          );
          print(response.statusCode);
          print(json.decode(response.body));
        } catch (error) {
          return Future.value("An error occured. Please try again.");
        }
        if (json.decode(response.body) == null) {
          return Future.value("An error occured. Please try again.");
        }

        if (response.statusCode > 250) {
          return Future.value(json.decode(response.body)["message"]);
        }

        return null;
      },
      onLogin: (data) async {
        _isSignUp = false;
        http.Response response;
        try {
          print({"email": data.name, "password": data.password});
          response = await http.post(
            "http://10.0.2.2:3000/api/signin",
            body: json.encode(
              {
                "email": data.name,
                "password": data.password,
              },
            ),
            headers: {
              "content-type": "application/json",
            },
          );
        } catch (error) {
          print(error.toString());
          return Future.value("An error occured. Please try again.");
        }
        if (json.decode(response.body) == null) {
          return Future.value("An error occured. Please try again.");
        }

        if (response.statusCode > 250) {
          return Future.value(json.decode(response.body)["message"]);
        }
        onLogin(json.decode(response.body));
        print(json.decode(response.body));

        return null;
      },
      onRecoverPassword: (data) {
        return Future.value("Ainnnnnnnn");
      },
    );
  }
}
// {
//   "fullName": "Darshan",
//   "email": "2020urc1416@mnit.ac.in",
//   "password": "123456",
//   "rollNumber": "2020urc1416",
//   "domainOfInterest": [ "Algorithms" ],
//   "college": "MNIT"
// }
