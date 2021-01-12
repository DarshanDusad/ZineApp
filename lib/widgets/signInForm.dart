import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  var key = GlobalKey<FormState>();
  var state = [true, false, false, false, false];
  var domains = ["BEE", "BME", "IC-MCU", "Algorithms", "Aeromodelling"];
  String name;
  bool error = false;
  void submitInfo() {
    if (key.currentState.validate()) {
      if (!state[0] && !state[1] && !state[2] && !state[3] && !state[4]) {
        setState(() {
          error = true;
        });
      } else {
        String domain;
        for (int i = 0; i < 5; i++) {
          if (state[i]) {
            domain = domains[i];
          }
        }
        key.currentState.save();

        Navigator.of(context).pop({"name": name, "domain": "DUMMY"});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "Welcome !",
              style: TextStyle(
                fontFamily: "Lobster",
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Tell us more",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: key,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your full name";
                      }
                      if (value.length < 3) {
                        return "Please enter a username of atleast 3 characters";
                      }

                      return null;
                    },
                    onSaved: (input) {
                      name = input;
                    },
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 14,
                        color: Colors.black.withOpacity(.65)),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                        labelText: "Full name",
                        labelStyle: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.grey[700],
                            fontSize: 15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        fillColor: Color.alphaBlend(
                          Theme.of(context).primaryColor.withOpacity(.07),
                          Colors.grey.withOpacity(.04),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   child: Text(
              //     "Your domain of interest",
              //     style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CheckboxListTile(
              //   value: state[0],
              //   onChanged: (val) {
              //     setState(() {
              //       if (val) {
              //         error = false;
              //         state[1] = false;
              //         state[2] = false;
              //         state[3] = false;
              //         state[4] = false;
              //       }
              //       state[0] = val;
              //     });
              //   },
              //   title: Text(
              //     "Basic Electrical and Electronics",
              //     style: TextStyle(
              //       fontFamily: "OpenSans",
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // CheckboxListTile(
              //   value: state[1],
              //   onChanged: (val) {
              //     setState(() {
              //       if (val) {
              //         error = false;
              //         state[0] = false;
              //         state[2] = false;
              //         state[3] = false;
              //         state[4] = false;
              //       }
              //       state[1] = val;
              //     });
              //   },
              //   title: Text(
              //     "Basic Mechanical",
              //     style: TextStyle(
              //       fontFamily: "OpenSans",
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // CheckboxListTile(
              //   value: state[2],
              //   onChanged: (val) {
              //     setState(() {
              //       if (val) {
              //         error = false;
              //         state[1] = false;
              //         state[0] = false;
              //         state[3] = false;
              //         state[4] = false;
              //       }
              //       state[2] = val;
              //     });
              //   },
              //   title: Text(
              //     "IC - MCU",
              //     style: TextStyle(
              //       fontFamily: "OpenSans",
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // CheckboxListTile(
              //   value: state[3],
              //   onChanged: (val) {
              //     setState(() {
              //       if (val) {
              //         error = false;
              //         state[1] = false;
              //         state[2] = false;
              //         state[0] = false;
              //         state[4] = false;
              //       }
              //       state[3] = val;
              //     });
              //   },
              //   title: Text(
              //     "Algorithms and Pseudocode",
              //     style: TextStyle(
              //       fontFamily: "OpenSans",
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // CheckboxListTile(
              //   value: state[4],
              //   onChanged: (val) {
              //     setState(() {
              //       if (val) {
              //         error = false;
              //         state[1] = false;
              //         state[2] = false;
              //         state[3] = false;
              //         state[0] = false;
              //       }
              //       state[4] = val;
              //     });
              //     print(state[4]);
              //   },
              //   title: Text(
              //     "Aeromodelling",
              //     style: TextStyle(
              //       fontFamily: "OpenSans",
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // if (error)
              //   Container(
              //     margin: EdgeInsets.only(bottom: 20),
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "Please fill your domain of interest",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 12,
              //         color: Colors.red,
              //       ),
              //     ),
              //   ),
              RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: submitInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
