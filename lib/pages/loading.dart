import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:tame_terong/classes/user_account.dart';
import 'package:tame_terong/pages/error.dart';
import 'package:tame_terong/pages/home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, this.loadingTitle = "Loading..."});

  final String loadingTitle;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String message = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserSetup();
  }

  Future<void> UserSetup() async {
    Map? account = await UserAccount().loadSavedAccount();

    account != null
        ? message = "Welkam ${account['username']}!!"
        : log("tingtung");

    await Future.delayed(const Duration(seconds: 1), () {
      if (account != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ErrorPage(
                      message: "account not found",
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(widget.loadingTitle), Text(message)],
        ),
      ),
    );
  }
}
