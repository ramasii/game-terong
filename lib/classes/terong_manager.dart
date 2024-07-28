import 'package:tame_terong/classes/terong_v2.dart';

class TerongManager {
  static TerongV2 terong = TerongV2(
      id: "terong",
      name: "Terong",
      description: "Sebuah terong",
      creator: "Anak GT",
      img: "terong bersih.png");

  static TerongV2 terongPixel = TerongV2(
      id: "terongPixel",
      name: "Terong Pixel",
      description: "Terong kok kotak-kotak?",
      creator: "Wapa",
      img: "terong pixel.png",
      timeSpawnStart: 11,
      timeSpawnEnd: 12,
      probability: 1000);

  static TerongV2 terongMas = TerongV2(
    id: "terongMas",
    name: "Terong Mas",
    description: "Apakah kamu suka terong? atau suka emas? bagaimana jika Terong Mas?",
    creator: "Wapa",
    img: "terong mas.png",
    timeSpawnEnd: 14,
    timeSpawnStart: 13,
    probability: 2000,
  );

  static TerongV2 terongIblis = TerongV2(
      id: "terongIblis",
      name: "Tervil",
      description: "Jangan di luar rumah kalo sudah Maghrib",
      creator: "Wapa",
      img: "iblis terong.png",
      timeSpawnStart: 0,
      timeSpawnEnd: 1,
      probability: 1000);

  static TerongV2 terongMalaikat = TerongV2(
      id: "terongMalaikat",
      name: "Terongel",
      description: "Terong yang terbuat dari cahaya",
      creator: "Wapa",
      img: "malaikat terong.png",
      timeSpawnStart: 6,
      timeSpawnEnd: 7,
      probability: 1000);

  List<TerongV2> terongList = [
    terong,
    terongPixel,
    terongMas,
    terongMalaikat,
    terongIblis
  ];

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
