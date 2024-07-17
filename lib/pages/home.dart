import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tame_terong/packages.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import '../classes/terong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Terong terong = Terong();

  // anonym auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  // analytic
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();

    SetupTerong();
    _signInAnonymously();
    SetupAnalytics();
  }

  Future SetupAnalytics() async {
    await analytics.setAnalyticsCollectionEnabled(true);
  }

  Future SetupTerong() async {
    await terong.ReadTerong();
    setState(() {
      log("Setup Terong");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
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

            // await FirestoreService().addUser("usnm", "pass");

            await analytics.logEvent(
                name: "seratus_terong",
                parameters: {"terongCount": terong.count});
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

  Future<void> _signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      setState(() {
        _user = userCredential.user;
      });
      print("Signed in with temporary account.");
    } catch (e) {
      print("Failed to sign in anonymously: $e");
    }
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String username, String pass) async {
    try {
      await _firestore.collection('user_accounts').doc(username).set({
        'username': username,
        'password': pass,
        'date_created': FieldValue.serverTimestamp(),
        'date_edited': FieldValue.serverTimestamp(),
      });
      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
