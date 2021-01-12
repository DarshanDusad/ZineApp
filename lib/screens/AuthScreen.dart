import 'dart:convert';
import 'dart:io';
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
    //ref.setString("domain", (data["user"]["domainOfInterest"][0]));
    ref.setString("uid", data["user"]["_id"]);
    print("uid:" + data["user"]["_id"]);
    Provider.of<Data>(context, listen: false).addData(data["token"],
        data["user"]["fullName"], data["user"]["email"], data["user"]["_id"]);
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
          print("reached");
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
                // "domainOfInterest": [map["domain"].toString()],
                "college": data.name.endsWith("@mnit.ac.in") ? "MNIT" : "IIITK",
              },
            ),
          );
          var body = json.decode(response.body);
          if (body == null) {
            return Future.value("An error occured. Please try again.");
          }

          if (response.statusCode > 250) {
            return Future.value(json.decode(response.body)["message"]);
          }
          print(body);
          if (body != null && response.statusCode < 250) {
            var uid = body["data"]["_id"];

            print("uid:" + uid);
            var room1 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ff2fbc9d0eec312cbbb6d95",
                },
              ),
            );
            var room2 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ff2fbe0d0eec312cbbb6d96",
                },
              ),
            );
            var room3 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ff2fbe5d0eec312cbbb6d97",
                },
              ),
            );
            var room4 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ff3517c1273f27108900481",
                },
              ),
            );
            var room5 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ff8699f9b6aaa69ffe0266b",
                },
              ),
            );
            var room6 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ffc310d5bfdb84beba3ffa9",
                },
              ),
            );
            var room7 = await http.post(
              "http://10.0.2.2:3000/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ffc31195bfdb84beba3ffaa",
                },
              ),
            );
            if (json.decode(room1.body) == null ||
                json.decode(room2.body) == null ||
                json.decode(room3.body) == null ||
                json.decode(room4.body) == null ||
                json.decode(room5.body) == null ||
                json.decode(room6.body) == null ||
                json.decode(room7.body) == null) {
              return Future.value("An error occured. Please try again.");
            }
            if (room1.statusCode > 250) {
              return Future.value(json.decode(room1.body)["message"]);
            }
            if (room2.statusCode > 250) {
              return Future.value(json.decode(room2.body)["message"]);
            }
            if (room3.statusCode > 250) {
              return Future.value(json.decode(room3.body)["message"]);
            }
            if (room4.statusCode > 250) {
              return Future.value(json.decode(room4.body)["message"]);
            }
            if (room5.statusCode > 250) {
              return Future.value(json.decode(room5.body)["message"]);
            }
            if (room6.statusCode > 250) {
              return Future.value(json.decode(room6.body)["message"]);
            }
            if (room7.statusCode > 250) {
              return Future.value(json.decode(room7.body)["message"]);
            }
            print(json.decode(room1.body));
          }
        } catch (error) {
          return Future.value("An error occured. Please try again.");
        }

        return Future.value(null);
      },
      onLogin: (data) async {
        _isSignUp = false;
        http.Response response;
        try {
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
          var body = json.decode(response.body);
          if (body == null) {
            return Future.value("An error occured. Please try again.");
          }

          if (response.statusCode > 250) {
            return Future.value(json.decode(response.body)["message"]);
          }
          print(body);
        } catch (error) {
          print(error.toString());
          return Future.value("An error occured. Please try again.");
        }

        onLogin(json.decode(response.body));

        return Future.value(null);
      },
      onRecoverPassword: (data) {
        return Future.value("Ainnnnnnnn");
      },
    );
  }
}
// {
//   "fullName": "Darshan",
//   "email": "2020qqq1416@mnit.ac.in",
//   "password": "123456",
//   "rollNumber": "2020urc1416",
//   "domainOfInterest": [ "BME" ],
//   "college": "MNIT"
// }
