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
  late TerongManager terongManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    terongManager = TerongManager();
  }

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
          itemCount: terongManager.terongList.length,
          itemBuilder: (context, index) {
            TerongV2 terong = terongManager.terongList[index];
            return Card(
              color: const Color.fromARGB(255, 77, 19, 129),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TerongTile(terong),
            );
          }),
    );
  }

  ListTile TerongTile(TerongV2 terong) {
    return ListTile(
      onTap: () {
        log("klik terong detail");
        ShowTerongDetail(terong);
      },
      leading: Image.asset(
        "assets/images/${terong.img}",
        // TODO: tambahkan progress indicator ketika gambar belum dimuat
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame != null) {
            return child;
          } else {
            return CircularProgressIndicator(
              color: Colors.indigo,
            );
          }
        },
      ),
      title: Text(terong.name),
      subtitle: Text(terong.timeSpawnStart != null
          ? "Jam ${terong.timeSpawnStart.toString().length == 1 ? 0 : ''}${terong.timeSpawnStart}.00 - ${terong.timeSpawnEnd.toString().length == 1 ? 0 : ''}${terong.timeSpawnEnd}.00"
          : "Tersedia 24 jam"),
      trailing: Text("1:${terong.probability}"),
    );
  }

  Future<dynamic> ShowTerongDetail(TerongV2 terong) {
    return showDialog(
        context: context,
        builder: (_) {
          double screenWidth = MediaQuery.of(context).size.width;
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                title: Row(
                  children: [
                    Expanded(child: Text(terong.name)),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close))
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Tutup",
                        style: TextStyle(
                            color: Color.fromARGB(255, 242, 229, 255)),
                      ))
                ],
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // gambar
                    Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth / 2,
                        ),
                        child: Image.asset("assets/images/${terong.img}"),
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    //desc
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        terong.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(),
                    //punya luwh
                    Text("Punyamu: ${terong.count}"),
                    Divider(
                      color: Colors.transparent,
                    ),
                    // jam muncul
                    // jangan hiraukan caraku menampilkan jam dengan format 24 jam :v
                    terong.timeSpawnStart != null
                        ? Text(
                            "Muncul jam ${terong.timeSpawnStart.toString().length == 1 ? 0 : ''}${terong.timeSpawnStart}.00 sampai ${terong.timeSpawnEnd.toString().length == 1 ? 0 : ''}${terong.timeSpawnEnd}.00")
                        : Text("Terong ini tersedia 24 jam."),
                    Text(
                        "Setiap ${terong.probability} klik akan mendapatkan satu ${terong.name}.")
                  ],
                ),
              ),
            ),
          );
        });
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
