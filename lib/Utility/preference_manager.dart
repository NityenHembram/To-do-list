import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/Utility/constants.dart';
import 'package:to_do_list/db/database.dart';

class PreferenceManager {
  // Singleton instance
  static final PreferenceManager _instance = PreferenceManager._internal();

  // Private constructor
  PreferenceManager._internal();

  // Factory constructor
  factory PreferenceManager() {
    return _instance;
  }

  // Method to set a value (String, int, bool, double, or List<String>)
  Future<bool> setValue(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else {
      throw Exception("Invalid value type");
    }
  }

  // Method to get a value
  Future<dynamic> getValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  // Method to remove a value
  Future<bool> removeValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // Method to clear all preferences
  Future<bool> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<void> saveTask(TasksListData task) async {
    String jsonString = jsonEncode(task.toJson());
    setValue(Constants.TASK_LIST_KEY, jsonString);
  }

  Future<TasksListData?> getTask() async {
    String jsonString =  await getValue(Constants.TASK_LIST_KEY);
    if (jsonString != null && jsonString.isNotEmpty) {
      print("this is the ${jsonString}");
      Map<String, dynamic> json = jsonDecode(jsonString);
      return TasksListData.fromJson(json);
    }
    return null;
  }
}
