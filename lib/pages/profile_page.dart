import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tame_terong/pages/pages.dart';
import 'package:tame_terong/pages/terong_drop.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(signInOption: SignInOption.standard);
  User? user;

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

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TerongkuPage()));
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
            user == null
                ? const Icon(
                    Icons.account_circle_outlined,
                    size: 60,
                    color: Color(0xFFFFFFFF),
                  )
                : ClipOval(
                    child: Image.network(user!.photoURL!, width: 60),
                  ),
            // divider
            const VerticalDivider(
              color: Colors.transparent,
            ),
            // tampilan username email / login
            Expanded(
              child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  user = snapshot.data; // ubah nilai variabel user

                  if (snapshot.hasData) {
                    log("already logged-in");
                    return UsernameEmail(); // ketika user sudah login
                  }
                  print("not logged-in");
                  return SigninButton(); // tombol untuk login
                },
              ),
            ),
            // tombol edit
            EditButton(),
          ],
        ),
      ),
    );
  }

  Widget EditButton() {
    if (user != null) {
      return IconButton(
          onPressed: () {
            log("edit username");
          },
          icon: const Icon(Icons.edit));
    } else {
      return Container();
    }
  }

  TextButton SigninButton() {
    return TextButton(
        onPressed: () async {
          log("pencet login");
          user = await signInWithGoogle();
        },
        child: Container(
          constraints: BoxConstraints(maxHeight: 40),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset("assets/images/google logo.png"),
              VerticalDivider(),
              Text(
                "Sign-in with Google",
              )
            ],
          ),
        ));
  }

  Column UsernameEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: Text(
            user!.displayName!,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        FittedBox(
          child: Text(
            user!.email!,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  AppBar ProfileAppBar() {
    return AppBar(
        title: const Text(
          "Profil (on progress)",
        ),
        centerTitle: true);
  }

  Future<User?> signInWithGoogle() async {
    int step = 0;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        log("The user canceled the sign-in");
        return null;
      }

      step = 1;
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      step = 2;
      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      step = 3;
      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      log(e.toString() + step.toString());
      return null;
    }
  }
}
