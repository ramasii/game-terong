import 'dart:developer';

import 'package:flutter/material.dart';
import '../classes/terong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Terong terong = Terong();

  @override
  void initState() {
    super.initState();
    SetupTerong();
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
                style: TextStyle(
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
}
