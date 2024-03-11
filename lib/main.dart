import 'package:cricket_team_manager_pro/firebase_options.dart';
import 'package:cricket_team_manager_pro/pages/auth/auth_redirector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket Manager',
      theme: ThemeData(
          colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.green[900]!,
        onPrimary: Colors.green[200]!,
        secondary: Colors.green[600]!,
        onSecondary: Colors.grey[200]!,
        error: Colors.red[900]!,
        onError: Colors.grey[200]!,
        background: const Color.fromARGB(255, 20, 20, 20),
        onBackground: Colors.grey[200]!,
        surface: Colors.transparent,
        onSurface: Colors.grey[200]!,
      )),
      home: const AuthRedirector(),
    );
  }
}
