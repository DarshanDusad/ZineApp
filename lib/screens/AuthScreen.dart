import 'dart:convert';
import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:zine/widgets/signInForm.dart';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";
import 'package:provider/provider.dart';
import 'package:zine/providers/data.dart';

const mainUrl = "18.207.115.53:3000";
const testUrl = "10.0.2.2";
const url = "18.207.115.53:3000";

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
        if (value.endsWith("@zine.co.in")) {
          return null;
        }
        if (value.length != 27 && value.length != 22) {
          return "Please enter a valid college email address";
        }
        if ((value.startsWith("2020") && value.endsWith("@mnit.ac.in")) ||
            (value.startsWith("2020") && value.endsWith("@iiitkota.ac.in"))) {
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
          signupButton: "Sign Up",
          recoverPasswordDescription: "Send us a mail to reset your password",
          recoverPasswordIntro: "Enter your college email id here",
          recoverPasswordSuccess: "We'll get in touch soon.",
          recoverPasswordButton: "Send"),
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
            "https://$url/api/signup",
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
                "college": data.name.endsWith("@mnit.ac.in") ? "MNIT" : "IIIT",
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
              "http://$url/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ffc310d5bfdb84beba3ffa9",
                  "userName": map["name"].toString()
                },
              ),
            );
            var room2 = await http.post(
              "http://$url/api/joinroom",
              headers: {
                "content-type": "application/json",
              },
              body: json.encode(
                {
                  "userId": uid,
                  "roomId": "5ffc31195bfdb84beba3ffaa",
                  "userName": map["name"].toString()
                },
              ),
            );

            if (json.decode(room1.body) == null ||
                json.decode(room2.body) == null) {
              return Future.value("An error occured. Please try again.");
            }
            if (room1.statusCode > 250) {
              return Future.value(json.decode(room1.body)["message"]);
            }
            if (room2.statusCode > 250) {
              return Future.value(json.decode(room2.body)["message"]);
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
            "http://$url/api/signin",
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
      onRecoverPassword: (data) async {
        FocusScope.of(context).unfocus();
        final Email email = Email(
          subject: "Password reset request",
          body:
              "I have forgotten my password for id $data on the Zine Communication Channel. Please reset it to <enter new password here>.",
          isHTML: false,
          recipients: [
            "pavnesh@zine.co.in",
          ],
        );
        await FlutterEmailSender.send(email);
        return Future.value(null);
      },
    );
  }
}
