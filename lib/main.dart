import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import './pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GameTerongTheme(),
      // home: const LoadingPage(loadingTitle: "Firebase Initialization"),
      navigatorObservers: [observer],
      home: const HomePage(title: "Game Terong"),
    );
  }

  ThemeData GameTerongTheme() {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF5A189A),
        onPrimary: Color.fromARGB(255, 242, 229, 255),
        secondary: Color(0xFF7B2CBF),
        onSecondary: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFEAD2FA),
        onSurface: Color(0xFF000000),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 37, 0, 48),
      appBarTheme: const AppBarTheme(
          color: Colors.transparent, elevation: 0, centerTitle: true),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
