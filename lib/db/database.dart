import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  BoolColumn get complete => boolean().withDefault(Constant(false))();
  DateTimeColumn get taskDateTime => dateTime().nullable()();
  IntColumn get priority => integer().withDefault(Constant(1))();
  IntColumn get taskListId => integer()
      .nullable()
      .customConstraint('REFERENCES tasks_list(id) ON DELETE CASCADE')();
}

class TasksList extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskListName => text().withLength(min: 1, max: 50)();
  BoolColumn get isDeleteAble => boolean().withDefault(Constant(true))();
}

class FinishedTaskTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  BoolColumn get complete => boolean().withDefault(Constant(false))();
  DateTimeColumn get taskDateTime => dateTime().nullable()();
  IntColumn get priority => integer().withDefault(Constant(1))();
  IntColumn get taskListId => integer()
      .nullable()
      .customConstraint('REFERENCES tasks_list(id) ON DELETE CASCADE')();
}

// 2. Define the database
@DriftDatabase(tables: [Tasks, TasksList, FinishedTaskTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Task List Operations
  Future<List<TasksListData>> getAllTaskLists() => select(tasksList).get();
  Future<int> addTaskList(TasksListCompanion taskList) =>
      into(tasksList).insert(taskList);
  Future<int> deleteTaskList(int id) =>
      (delete(tasksList)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> updateTaskList(int id, TasksListCompanion updatedTaskList) {
    return (update(tasksList)..where((tbl) => tbl.id.equals(id)))
        .write(updatedTaskList);
  }

  Future<String?> getTaskListNameById(int id) async {
    final result = await (select(tasksList)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return result
        ?.taskListName; // Return the `taskList` value or `null` if no match
  }

  // Task Operations
  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<void> addTask(TasksCompanion task) async {
    await into(tasks)
        .insert(task)
        .then((id) => {print(id)})
        .onError((e, s) => {print("error while adding task$e  $s")});
  }

  Future<int> updateTask(int id, TasksCompanion updateTasks) {
    return (update(tasks)..where((tbl) => tbl.id.equals(id)))
        .write(updateTasks);
  }

  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((tbl) => tbl.id.equals(id))).go();

  // Finished tasks Operations
  Future<List<FinishedTaskTableData>> getAllFinishedTask() =>
      select(finishedTaskTable).get();
  Future<int> addToFinishedTask(FinishedTaskTableCompanion finishedTask) =>
      into(finishedTaskTable).insert(finishedTask);
  Future<int> deleteFinishedTask(int id) =>
      (delete(finishedTaskTable)..where((tbl) => tbl.id.equals(id))).go();
  Future<int> getFinishedTaskCount() async {
    final query = select(finishedTaskTable).get();
    final result = await query; // Fetch the matching tasks
    return result.length; // Return the count of tasks
  }

  // Move a task from Tasks to FinishedTaskTable
  Future<void> moveToFinishedTask(int taskId) async {
    // Fetch the task from the Tasks table
    final task = await (select(tasks)..where((tbl) => tbl.id.equals(taskId)))
        .getSingleOrNull();

    if (task != null) {
      // Insert the task into FinishedTaskTable
      await into(finishedTaskTable).insert(FinishedTaskTableCompanion(
          title: Value(task.title),
          complete: Value(true),
          taskListId: Value(task.taskListId),
          priority: Value(task.priority),
          taskDateTime: Value(task.taskDateTime)));

      // Delete the task from the Tasks table
      await (delete(tasks)..where((tbl) => tbl.id.equals(taskId))).go();
    }
  }

// Move a task from FinishedTaskTable back to Tasks
  Future<void> moveToTask(int finishedTaskId) async {
    // Fetch the task from the FinishedTaskTable
    final finishedTask = await (select(finishedTaskTable)
          ..where((tbl) => tbl.id.equals(finishedTaskId)))
        .getSingleOrNull();

    if (finishedTask != null) {
      // Insert the task back into the Tasks table
      await into(tasks).insert(TasksCompanion(
          title: Value(finishedTask.title),
          complete: Value(false),
          taskListId: Value(finishedTask.taskListId),
          priority: Value(finishedTask.priority),
          taskDateTime: Value(finishedTask.taskDateTime)));

      // Delete the task from the FinishedTaskTable
      await (delete(finishedTaskTable)
            ..where((tbl) => tbl.id.equals(finishedTaskId)))
          .go();
    }
  }

  // Retrieve tasks for a specific task list
  Stream<List<Task>> watchTasksForTaskList(int taskListId) {
    return (select(tasks)..where((tbl) => tbl.taskListId.equals(taskListId)))
        .watch();
  }

  Future<int> getTaskCount(int id) async {
    final query = select(tasks)..where((tbl) => tbl.taskListId.equals(id));
    final result = await query.get(); // Fetch the matching tasks
    return result.length; // Return the count of tasks
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    // if (await file.exists()) {
    //   await file.delete(); // Delete old database file
    // }
    return NativeDatabase(file, setup: (db) {
      db.execute('PRAGMA foreign_keys = ON;');
    });
  });
  // return LazyDatabase(() async {
  //   final dbFolder = await getApplicationDocumentsDirectory();
  //   final file = File(p.join(dbFolder.path, 'app.db'));
  //
  //
  //
  //   print("${file}"); // Database file name
  //   return NativeDatabase(file);
  // });
}
