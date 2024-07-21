import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tame_terong/pages/pages.dart';
import 'package:tame_terong/pages/terong_drop.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: ProfileBody(),
    );
  }

  Container ProfileBody() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UsernameCard(),
          const Divider(
            color: Colors.transparent,
          ),
          MenuCard(),
          const Divider(
            color: Colors.transparent,
          ),
          SecondMenuCard()
        ],
      ),
    );
  }

  Card SecondMenuCard() {
    return Card(
      color: const Color.fromARGB(255, 57, 5, 103),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // terong drop
          ListTile(
            onTap: () {
              log("Terong drop");

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const TerongDrop()));
            },
            leading: const Text(
              "💦",
              style: TextStyle(fontSize: 20),
            ),
            title: const Text("Terong drop"),
            subtitle: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("Kapan kemunculan jenis terong lain?")),
            trailing: const Icon(Icons.chevron_right),
          ),
          // kata deve
          ListTile(
            onTap: () {
              log("Kata developernya");
            },
            leading: const Text(
              "💌",
              style: TextStyle(fontSize: 20),
            ),
            title: const Text("Kata developernya"),
            subtitle: const Text("Jadi gini bang..."),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Card MenuCard() {
    return Card(
      color: const Color.fromARGB(255, 77, 19, 129),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // terongku
          ListTile(
            onTap: () {
              log("Terongku");

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const TerongkuPage()));
            },
            leading: const Text(
              "🍆",
              style: TextStyle(fontSize: 20),
            ),
            title: const Text("Terongku"),
            subtitle: const Text("Lihat berapa banyak terongmu"),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              log("Berikan terong");
            },
            leading: const Icon(Icons.upload),
            title: const Text("Berikan terong"),
            subtitle: const Text("Terongin atau diterongin?"),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Card UsernameCard() {
    return Card(
      color: const Color(0xFF7B2CBF),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // ikon akun
            const Icon(
              Icons.account_circle_outlined,
              size: 60,
              color: Color(0xFFFFFFFF),
            ),
            // divider
            const VerticalDivider(
              color: Colors.transparent,
            ),
            // tampilan username dan email
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "usernameku",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Text(
                    "emailku@emailku.com",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            // tombol edit
            IconButton(
                onPressed: () {
                  log("edit username");
                },
                icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }

  AppBar ProfileAppBar() {
    return AppBar(
        title: const Text(
          "Profil (cuming soon)",
        ),
        centerTitle: true);
  }
}
