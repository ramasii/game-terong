import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tame_terong/classes/classes.dart';
import 'package:tame_terong/classes/terong_manager.dart';
import 'package:tame_terong/packages.dart';

class TerongkuPage extends StatefulWidget {
  const TerongkuPage({super.key});

  @override
  State<TerongkuPage> createState() => _TerongkuPageState();
}

class _TerongkuPageState extends State<TerongkuPage> {
  TerongManager terongManager = TerongManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TerongSetup();
  }

  Future<void> TerongSetup() async {
    await terongManager.LoadAllTerong();

    log("terong setup");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Terongku"),
        ),
        body: TerongkuBody());
  }

  ListView TerongkuBody() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: terongManager.terongList.length,
        itemBuilder: (context, index) {
          TerongV2 terong = terongManager.terongList[index];
          return Card(
            color: const Color.fromARGB(255, 67, 1, 133),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              onTap: () {
                log("tap ${terong.name}");
              },
              leading: SimpleShadow(
                  sigma: 5,
                  offset: Offset.zero,
                  child: Image.asset("assets/images/${terong.img}")),
              title: Text(terong.name),
              subtitle: Text("By ${terong.creator}"),
              trailing: Container(
                constraints: const BoxConstraints(maxWidth: 150),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    formatNumber(terong.count),
                    // terong.count.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          );
        });
  }

  String formatNumber(int number) {
    if (number >= 1000000000) {
      return (number / 1000000000).toStringAsFixed(1) + 'B';
    } else if (number >= 1000000) {
      return (number / 1000000).toStringAsFixed(1) + 'M';
    } else if (number >= 1000) {
      return (number / 1000).toStringAsFixed(1) + 'K';
    } else {
      return number.toString();
    }
  }
}
