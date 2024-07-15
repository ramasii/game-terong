import 'package:flutter/material.dart';
import './pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF5A189A),
          onPrimary: Color.fromARGB(255, 242, 229, 255),
          secondary: Color(0xFF7B2CBF),
          onSecondary: Color(0xFFFFFFFF),
          error: Color(0xFFB00020),
          onError: Color(0xFFFFFFFF),
          background: Color(0xFFF4E1FA),
          onBackground: Color(0xFF000000),
          surface: Color(0xFFEAD2FA),
          onSurface: Color(0xFF000000),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 37, 0, 48),
        appBarTheme: AppBarTheme(
            color: Colors.transparent, elevation: 0, centerTitle: true),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const HomePage(title: "Game Terong"),
    );
  }
}
