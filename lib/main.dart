import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/db/database.dart';
import 'package:to_do_list/screens/homepage.dart';
import 'package:to_do_list/res/image_path.dart';

  void main() {
    runApp( MyApp());
  }

  class MyApp extends StatelessWidget {
     MyApp({super.key});

    final AppDatabase database = AppDatabase();

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'ToDoList',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 10, 9, 14)),
          useMaterial3: true,
        ),
        home: SplashScreen(database: database)
      );
    }
  }


class SplashScreen extends StatefulWidget {
  final AppDatabase database;
  const SplashScreen({super.key, required this.database});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  Future<void> _navigateToHomePage() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate splash duration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(database: widget.database),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(child: Image.asset(ImagePath.appLogo,width: 300, height: 300,)),
    );
  }
}


