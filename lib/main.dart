import 'dart:async';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:to_do_list/Utility/constants.dart';
import 'package:to_do_list/Utility/preference_manager.dart';
import 'package:to_do_list/db/database.dart';
import 'package:to_do_list/screens/homepage.dart';
import 'package:to_do_list/res/image_path.dart';
import 'package:to_do_list/themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppDatabase database = AppDatabase();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList',
      theme: colorfulTheme,
      // darkTheme: darkTheme,
      home: SplashScreen(database: database),
      //   EditTaskScreen(
      // database: database,)
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
  final PreferenceManager pm = PreferenceManager();
  bool hasCreated = false;

  @override
  void initState() {
    super.initState();
    addPreDefineTasks();
  }

  Future<void> _navigateToHomePage() async {
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
      body: Center(
          child: Image.asset(
        ImagePath.appLogo,
        width: 300,
        height: 300,
      )),
    );
  }

  void addPreDefineTasks() async {
    // Check if predefined tasks have already been created
    var data = await pm.getValue(Constants.CREATE_TASKLIST);
    hasCreated = (data == null) ? false : true;
    if (!hasCreated) {
      // List of predefined task lists
      var preDefineTasksList = ['Default', 'Personal', 'Shopping', 'Wishlist'];

      // Add each task list to the database
      for (var taskList in preDefineTasksList) {
        await widget.database.addTaskList(
          TasksListCompanion(
            taskListName: drift.Value(taskList),
            isDeleteAble:
                drift.Value(taskList != 'Default'), // Set isDeleteAble
          ),
        );
      }

      // Mark that predefined tasks have been created
      await pm.setValue(Constants.CREATE_TASKLIST, true);
    }
    _navigateToHomePage();
  }
}
