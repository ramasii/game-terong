import 'package:shared_preferences/shared_preferences.dart';

class UserClicks {
  int count = 0;

  Future<void> Save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt("userClicks", count);
  }

  Future<void> Load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    count = prefs.getInt("userClicks") ?? 0;
  }
}
