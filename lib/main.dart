import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/database.dart';
import 'package:to_do_list/homepage.dart';
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
      home:AnimatedSplashScreen(duration:3000,splash: ImagePath.appLogo, nextScreen: Homepage(database: database), backgroundColor: Colors.lightBlue,)
    );
  }
}


