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
  List<Task> tasks = [];

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
                // Handle adding/removing list items manually
                if (newTasks.length > tasks.length) {
                  // New task added
                  final newTask = newTasks.last;
                  _listKey.currentState?.insertItem(newTasks.length - 1);
                } else if (newTasks.length < tasks.length) {
                  // Task removed
                  _listKey.currentState?.removeItem(
                    tasks.length - 1,
                        (context, animation) => _buildItem(tasks.last, animation),
                  );
                }
                tasks = newTasks;

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
            padding: const EdgeInsets.all(8.0),
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
                  onPressed: () {
                    if (taskController.text.trim().isNotEmpty) {
                      widget.database.addTask(
                        TasksCompanion(title: drift.Value(taskController.text.trim())),
                      );
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

  Widget _buildItem(Task task, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0), // Start from right for adding items
        end: Offset.zero,
      ).animate(animation),
      child: ListTile(
        title: Text(task.title),
        trailing: Checkbox(
          value: task.complete,
          onChanged: (value) {
            widget.database.deleteTask(task.id);
          },
        ),
      ),
    );
  }
}

