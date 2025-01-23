import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../db/database.dart';

class Utils {
  static void showAddTaskDialog(
    BuildContext context,
    AppDatabase database,
    TasksListData? item,
  ) {
    final TextEditingController _taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: item == null ? "Task Title" : item.taskList,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.trim().isNotEmpty) {
                  if (item == null) {
                    database.updateTaskList(item!.id, TasksListCompanion(
                      taskList: drift.Value(_taskController.text.trim()),
                    ));
                  } else {
                    database.addTaskList(TasksListCompanion(
                      taskList: drift.Value(_taskController.text.trim()),
                    ));
                    _taskController.clear();
                  }
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  static void showDeleteDialog(
      BuildContext context, TasksListData item, AppDatabase database) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text(
            "Do you really want to delete the ${item.taskList} list?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                database.deleteTaskList(item.id);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
