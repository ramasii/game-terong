import 'package:shared_preferences/shared_preferences.dart';

class TerongV2 {
  final String id;
  final String name;
  final String description;
  final String creator;
  int count = 0;
  String img;
  int probability = 1;
  int? timeSpawnStart, timeSpawnEnd;

  TerongV2(
      {required this.id,
      required this.name,
      required this.description,
      required this.creator,
      count,
      required this.img,
      probability,
      timeSpawnStart,
      timeSpawnEnd});

  // func
  Map toMap() {
    Map mapped = {
      "id": id,
      "name": name,
      "description": description,
      "creator": creator,
      "count": count,
      "img": img,
      "probability": probability,
      "time_spawn_start": timeSpawnStart,
      "time_spawn_end": timeSpawnEnd,
    };

    return mapped;
  }

  TerongV2 fromMap(Map mapped) {
    TerongV2 tempTerong = TerongV2(
        id: mapped['id'],
        name: mapped['name'],
        description: mapped['description'],
        count: mapped['count'],
        creator: mapped['creator'],
        img: mapped['img'],
        probability: mapped['probability'],
        timeSpawnStart: mapped['time_spawn_start'],
        timeSpawnEnd: mapped['time_spawn_end']);

    return tempTerong;
  }

  void Add(int amount) async {
    count += amount;
  }

  Future<void> Save() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setInt(id, count);
  }

  Future<void> Load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int tempCount = pref.getInt(id) ?? 0;

    count = tempCount;
  }
}
