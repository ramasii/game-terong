import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tame_terong/classes/terong_manager.dart';
import 'package:tame_terong/classes/terong_v2.dart';

class TerongDrop extends StatefulWidget {
  const TerongDrop({super.key});

  @override
  State<TerongDrop> createState() => _TerongDropState();
}

class _TerongDropState extends State<TerongDrop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Padding body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: TerongManager().terongList.length,
          itemBuilder: (context, index) {
            TerongV2 terong = TerongManager().terongList[index];
            return Card(
              color: const Color.fromARGB(255, 77, 19, 129),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ListTile(
                leading: Image.asset("assets/images/${terong.img}"),
                title: Text(terong.name),
                subtitle: Text(terong.timeSpawnStart != null
                    ? "Kemunculan jam: ${terong.timeSpawnStart}-${terong.timeSpawnEnd}"
                    : "Tersedia 24 jam"),
                trailing: Text("1:${terong.probability}"),
              ),
            );
          }),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Terong Drop"),
          Text(
            "Kapan terong jenis lain didapatkan?",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              log("info terong drop");
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Terong drop"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Tutup",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 242, 229, 255)),
                              ))
                        ],
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                "Di halaman ini menampilkan informasi kapan suatu terong muncul."),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            Image.asset("assets/images/tile terong pixel.png"),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            const Text(
                                "Menampilkan: \n- nama\n- waktu muncul (format 24 jam) \n- kemungkinan tiap klik (di gambar 1 terong setiap 1000 klik)")
                          ],
                        ),
                      ));
            },
            icon: const Icon(Icons.info_outline))
      ],
    );
  }
}
