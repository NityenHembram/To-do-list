import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              labelText: item == null ? "Task Title" : item.taskListName,
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
                  if (item != null) {
                    database.updateTaskList(
                        item.id,
                        TasksListCompanion(
                          taskListName:
                              drift.Value(_taskController.text.trim()),
                        ));
                  } else {
                    database.addTaskList(TasksListCompanion(
                      taskListName: drift.Value(_taskController.text.trim()),
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
            "Do you really want to delete the ${item.taskListName} list?",
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

  static String formateDateAndTime(String format,
      {String date = '', String time = ''}) {
    if (date.isNotEmpty) {
      DateTime parseDate = DateTime.parse(date);
      String formatedDate = DateFormat(format).format(parseDate);
      return formatedDate;
    } else if (time.isNotEmpty) {
      DateTime parseTime = DateFormat("HH:mm").parse(time);
      String formatedTime = DateFormat(format).format(parseTime);
      return formatedTime;
    } else {
      return '';
    }
  }

  static String convertDateToString(String format, DateTime dateTime) {
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final String formatedDate = DateFormat(format).format(date);
    return formatedDate;
  }

  static String convertTimeToString(String format, String timeOfDay ) {
      DateTime parseTime = DateFormat("HH:mm").parse(timeOfDay);
    final String formatedDate = DateFormat(format).format(parseTime);
    return formatedDate;
  }


  static String convertDateTimeToString(String format, DateTime dateTime) {
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    final String formatedDate = DateFormat(format).format(date);
    return formatedDate;
  }

}
