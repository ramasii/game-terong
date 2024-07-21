import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserAccount {
  String? username;
  String? pass;
  DateTime? date_created;
  DateTime? date_edited;

  UserAccount({this.username, this.pass, this.date_created, this.date_edited});

  // READ
  Future<Map?> loadSavedAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? encodedUserAccount = prefs.getString("userAccount");

    if (encodedUserAccount != null) {
      print("account found!");

      Map<String, dynamic> userAccount = jsonDecode(encodedUserAccount);

      // username = userAccount['username'];
      // pass = userAccount['pass'];
      // date_created = userAccount['date_created'];
      // date_edited = userAccount['date_edited'];

      return userAccount;
    } else {
      log("account not found");
      return null;
    }
  }

  // WRITE
  Future<void> saveAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (username != null && pass != null) {
      Map userAccount = {
        "username": username,
        "pass": pass,
        "date_created": date_created,
        "date_edited": date_edited
      };

      String encoded = jsonEncode(userAccount);

      await prefs.setString("userAccount", encoded);
    }
  }

  //DELETE
  Future<void> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = null;
    pass = null;
    date_created = null;
    date_edited = null;

    await prefs.remove("userAccount");
  }
}
