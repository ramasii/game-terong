
import 'package:shared_preferences/shared_preferences.dart';

class TerongPixel {
  int count;

  TerongPixel({this.count = 0});

  // func
  void Add(int amount) async {
    count += amount;
  }

  Future<void> Save() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setInt("terongPixelCount", count);
  }

  Future<void> Load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int terongPixelCount = pref.getInt("terongPixelCount") ?? 0;

    count = terongPixelCount;
  }
}
