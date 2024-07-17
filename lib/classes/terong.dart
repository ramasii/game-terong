
import 'package:shared_preferences/shared_preferences.dart';

class Terong {
  int count;

  Terong({this.count = 0});

  // func
  void AddTerong(int amount) async {
    count += amount;
  }

  Future<void> WriteTerong() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setInt("terongCount", count);
  }

  Future<void> ReadTerong() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int terongCount = pref.getInt("terongCount") ?? 0;

    count = terongCount;
  }
}
