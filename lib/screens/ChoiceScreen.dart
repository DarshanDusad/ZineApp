import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';

class ChoiceScreen extends StatelessWidget {
  static const route = "/choice";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ZINE",
                style: TextStyle(
                  fontFamily: "Megatron",
                  fontSize: 64,
                  color: Colors.white,
                ),
              ),
              Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: 125,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/auth");
                          Provider.of<Data>(context, listen: false)
                              .isAnonymous = false;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: 125,
                          alignment: Alignment.center,
                          child: Text(
                            "Just Explore",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/home");
                          Provider.of<Data>(context, listen: false)
                              .isAnonymous = true;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
