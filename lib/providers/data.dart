import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  String token;
  String name;
  String email;
  String domain;

  void addData(String token, String name, String email, String domain) {
    this.token = token;
    this.name = name;
    this.email = email;
    this.domain = domain;
    notifyListeners();
  }

  void clear() {
    this.token = null;
    this.name = null;
    this.email = null;
    this.domain = null;
  }
}
