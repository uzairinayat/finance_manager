import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _name = "";

  String get name => _name;

  // Load name from SharedPreferences
  Future<void> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? "";
    notifyListeners();
  }

  // Save name to SharedPreferences
  Future<void> setName(String name) async {
    _name = name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    notifyListeners();
  }
}
