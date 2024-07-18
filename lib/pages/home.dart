import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tame_terong/classes/terong_pixel.dart';
import 'package:tame_terong/packages.dart';
import 'package:tame_terong/pages/profile_page.dart';
import '../classes/terong.dart';
import 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title = "Game Terong"});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Terong terong = Terong();
  TerongPixel terongPixel = TerongPixel();

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
    await terong.ReadTerong();
    await terongPixel.Load();

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
                '${terong.count}',
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
            setState(() {
              terong.AddTerong(1);
              terong.WriteTerong();
            });

            CheckThenGetTerong();
            await CheckThenSendEvent();
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
    // kirim event
    if (terong.count == 100) {
      await analytics.logEvent(
          name: "seratus_terong", parameters: {"terongCount": terong.count});
    }
  }

  CheckThenGetTerong() {
    // cek waktu
    DateTime dateTime = DateTime.now();

    // jika (jam < 12 atau jam >= 11) dan terong kelipatan 1000
    // maka dapatkan terong pixel
    if ((dateTime.hour < 12 || dateTime.hour >= 11) &&
        (terong.count % 1000 == 0)) {
      // beri terong pixel
      terongPixel.Add(1);
      terongPixel.Save();

      // dialog selamat
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Selamat!"),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Kamu mendapatkan Terong Pixel 😋🍆"),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Image.asset("assets/images/terong pixel.png")
                  ],
                ),
              ),
            );
          });
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
