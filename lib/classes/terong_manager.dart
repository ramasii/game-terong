import 'package:tame_terong/classes/terong_v2.dart';

class TerongManager {
  static TerongV2 terong =
      TerongV2(id: "terong", name: "Terong", description: "Sebuah terong", creator: "Anak GT", img: "terong bersih.png");

  static TerongV2 terongPixel = TerongV2(
      id: "terongPixel",
      name: "Terong Pixel",
      description: "Terong kok kotak-kotak?",
      creator: "Wapa",
      img: "terong pixel.png",
      timeSpawnStart: 11,
      timeSpawnEnd: 12,
      probability: 1000);

  List<TerongV2> terongList = [terong, terongPixel];

  // func
  Future<void> LoadAllTerong() async {
    for (var terong in terongList) {
      await terong.Load();
    }
  }

  Future<void> SaveAllTerong() async {
    for (var terong in terongList) {
      await terong.Save();
    }
  }
}
