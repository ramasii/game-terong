import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tame_terong/pages/error.dart';
import 'pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, required this.loadingTitle});

  final String loadingTitle;

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialization = Firebase.initializeApp();

    return MaterialApp(
      title: loadingTitle,
      home: FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomePage(title: "Game Terong");
          }
          return const ErrorPage();
        },
      ),
    );
  }
}
