import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/database.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(database: database),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final AppDatabase database;
  const MyHomePage({super.key, required this.database});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: StreamBuilder<List<Task>>(
        stream: database.select(database.tasks).watch(), // Listen for changes
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                trailing: Checkbox(
                  value: task.complete,
                  onChanged: (value) {
                    database.deleteTask(task.id);
                    // database.update(database.tasks)
                    //   ..where((tbl) => tbl.id.equals(task.id))
                    //   ..write(TasksCompanion(complete: Value(value!)));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await database.addTask(TasksCompanion(title: Value("New Task")));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


