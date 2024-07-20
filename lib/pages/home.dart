import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tame_terong/classes/terong_manager.dart';
import 'package:tame_terong/classes/terong_v2.dart';
import 'package:tame_terong/packages.dart';
import 'package:tame_terong/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title = "Game Terong"});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TerongManager terongManager = TerongManager();

  // anonym auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  // analytic
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();

    SetupTerong();
    // _signInAnonymously();
    SetupAnalytics();
  }

  Future SetupAnalytics() async {
    await analytics.setAnalyticsCollectionEnabled(true);
  }

  Future SetupTerong() async {
    await terongManager.LoadAllTerong();

    setState(() {
      log("Setup Terong");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                '${terongManager.terongList[0].count}',
                style: const TextStyle(
                    color: Color.fromARGB(255, 238, 221, 255), fontSize: 50),
              ),
            ),
            TerongButton(),
          ],
        ),
      ),
    );
  }

  AppBar HomeAppBar() {
    return AppBar(
      // title: Text(widget.title),
      backgroundColor: Colors.transparent,
      actions: [ProfileButton()],
    );
  }

  IconButton ProfileButton() {
    return IconButton(
      onPressed: () {
        // go to akun page
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ProfilePage()));
      },
      icon: Icon(Icons.person),
      tooltip: "Profil",
    );
  }

  // func
  Widget TerongButton() {
    return Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
        child: IconButton(
          iconSize: 250,
          onPressed: () async {
            TerongV2 terong = terongManager.terongList[0];
            setState(() {
              terong.Add(1);
              terong.Save();
            });

            await CheckThenSendEvent();

            await CheckThenGetTerong();
          },
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Image.asset(
            "assets/images/terong bersih.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
        ));
  }

  Future<void> CheckThenSendEvent() async {
    // declare
    TerongV2 terongV2 = terongManager.terongList[0];
    // kirim event
    if (terongV2.count == 100) {
      await analytics.logEvent(
          name: "seratus_terong", parameters: {"terongCount": terongV2.count});
    }
  }

  CheckThenGetTerong() async {
    // declare
    DateTime dateTime = DateTime.now();
    TerongV2 terongBiasa = terongManager.terongList[0];

    // check V2
    for (var terong in terongManager.terongList) {
      if (terong.id != "terong" &&
          terong.timeSpawnEnd != null &&
          terong.timeSpawnStart != null) {
        if ((dateTime.hour < terong.timeSpawnEnd! ||
                dateTime.hour >= terong.timeSpawnStart!) &&
            (terongBiasa.count % terong.probability == 0)) {
          terong.Add(1);
          terong.Save();

          // dialog selamat
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Selamat!"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kamu mendapatkan ${terong.name} 😋🍆"),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Image.asset("assets/images/${terong.img}"),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Text("By: ${terong.creator}")
                    ],
                  ),
                );
              });
        }
      }
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      setState(() {
        user = userCredential.user;
      });
      print("Signed in with temporary account.");
    } catch (e) {
      print("Failed to sign in anonymously: $e");
    }
  }
}
