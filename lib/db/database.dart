import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part '../database.g.dart';



class Tasks extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  BoolColumn get complete => boolean().withDefault(Constant(false))();
  IntColumn get taskListId => integer().nullable().customConstraint('REFERENCES tasks_list(id) ON DELETE CASCADE')();

}

class TasksList extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskList => text().withLength(min: 1, max: 50)();
  BoolColumn get isDeleteAble => boolean().withDefault(Constant(true))();
}


// 2. Define the database
@DriftDatabase(tables: [Tasks,TasksList])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Task List Operations
  Future<List<TasksListData>> getAllTaskLists() => select(tasksList).get();
  Future<int> addTaskList(TasksListCompanion taskList) => into(tasksList).insert(taskList);
  Future<int> deleteTaskList(int id) => (delete(tasksList)..where((tbl) => tbl.id.equals(id))).go();
  Future<int> updateTaskList(int id, TasksListCompanion updatedTaskList) {
    return (update(tasksList)..where((tbl) => tbl.id.equals(id))).write(updatedTaskList);
  }


  // Task Operations
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<int> addTask(TasksCompanion task) => into(tasks).insert(task);
  Future<int> deleteTask(int id) => (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();

  // Retrieve tasks for a specific task list
  Stream<List<Task>> watchTasksForTaskList(int taskListId) {
    return (select(tasks)..where((tbl) => tbl.taskListId.equals(taskListId))).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));

    // if (await file.exists()) {
    //   await file.delete(); // Delete old database file
    // }

    print("${file}");// Database file name
    return NativeDatabase(file);
  });
}