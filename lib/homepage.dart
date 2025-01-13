import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'database.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key, required this.database});

  final AppDatabase database;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Task> tasks = []; // Previous state of tasks

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: widget.database.select(widget.database.tasks).watch(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final newTasks = snapshot.data!;
                _updateAnimatedList(newTasks);

                return AnimatedList(
                  key: _listKey,
                  initialItemCount: tasks.length,
                  itemBuilder: (context, index, animation) {
                    final task = tasks[index];
                    return _buildItem(task, animation);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "New Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), padding: EdgeInsets.all(20)),
                  onPressed: () {
                    if (taskController.text.trim().isNotEmpty) {
                      widget.database.addTask(TasksCompanion(
                        title: drift.Value(taskController.text.trim()),
                      ));
                      taskController.clear();
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateAnimatedList(List<Task> newTasks) {
    final oldTasks = List<Task>.from(tasks);
    tasks = newTasks;

    // Detect additions
    for (var i = 0; i < tasks.length; i++) {
      if (i >= oldTasks.length || tasks[i] != oldTasks[i]) {
        _listKey.currentState
            ?.insertItem(i, duration: Duration(milliseconds: 300));
      }
    }

    // Detect deletions
    for (var i = 0; i < oldTasks.length; i++) {
      if (i >= tasks.length || oldTasks[i] != tasks[i]) {
        final removedTask = oldTasks[i];
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildItem(removedTask, animation),
          duration: Duration(milliseconds: 300),
        );
      }
    }
  }

  // Widget _buildItem(Task task, Animation<double> animation,
  //     {bool isRemoving = false}) {
  //   final offsetAnimation = isRemoving
  //       ? Tween<Offset>(begin: Offset.zero, end: Offset(-1.0, 0.0))
  //           .animate(animation)
  //       : Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
  //           .animate(animation);
  //
  //   return SlideTransition(
  //     position: offsetAnimation,
  //     child: Card(
  //       child: ListTile(
  //         title: Text(task.title),
  //         trailing: Checkbox(
  //           value: task.complete,
  //           onChanged: (value) {
  //             widget.database.deleteTask(task.id);
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildItem(Task task, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0), // Start from right for adding items
        end: Offset.zero,
      ).animate(animation),
      child: Card(
        child: ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.complete,
            onChanged: (value) {
              widget.database.deleteTask(task.id);
            },
          ),
        ),
      ),
    );
  }
}

// Widget _buildItem(Task task, Animation<double> animation) {
//   return SlideTransition(
//     position: Tween<Offset>(
//       begin: Offset(1.0, 0.0), // Start from right for adding items
//       end: Offset.zero,
//     ).animate(animation),
//     child: ListTile(
//       title: Text(task.title),
//       trailing: Checkbox(
//         value: task.complete,
//         onChanged: (value) {
//           widget.database.deleteTask(task.id);
//         },
//       ),
//     ),
//   );
// }
