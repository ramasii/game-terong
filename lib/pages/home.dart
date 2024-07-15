import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameterong/packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int terongCount = 0;

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
            Text(
              '$terongCount',
              style: TextStyle(
                  color: Color.fromARGB(255, 242, 229, 255), fontSize: 50),
            ),
            TerongButton(),
          ],
        ),
      ),
    );
  }

  // func
  void AddTerong(int amount) {
    terongCount += amount;
  }

  Widget TerongButton() {
    return Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
        child: IconButton(
          iconSize: 250,
          onPressed: () {
            setState(() {
              AddTerong(1);
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
