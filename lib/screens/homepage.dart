import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list/Utility/constants.dart';
import 'package:to_do_list/Utility/preference_manager.dart';
import 'package:to_do_list/res/image_path.dart';
import 'package:to_do_list/screens/task_list_screen.dart';
import '../Utility/utils.dart';
import '../db/database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.database});

  final AppDatabase database;

  @override
  State<Homepage> createState() => _HomepageState();
}

String? selectedItem;

class _HomepageState extends State<Homepage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Task> tasks = []; // Previous state of tasks
  var selectedTaskListItem = 'Default';
  var selectedTaskListItemId = 0;
  final preferenceManager = PreferenceManager();

  final GlobalKey _buttonKey = GlobalKey(); // To get button position
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    initialization();
    super.initState();
  }

  initialization() async {
    await preferenceManager.getValue(Constants.TASK_LIST_KEY).then((onValue) {
      selectedTaskListItem = onValue;
    });
    await preferenceManager
        .getValue(Constants.TASK_LIST_ID_KEY)
        .then((onValue) {
      setState(() {
        selectedTaskListItemId = onValue;
      });
    });
  }

  void _showPopup(BuildContext context) {
    // Get the button's position

    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    // Create the OverlayEntry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Transparent background to detect taps outside the popup
            GestureDetector(
              onTap: () {
                _overlayEntry?.remove(); // Close the popup
              },
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            // Positioned popup
            Positioned(
              left: offset.dx,
              bottom: MediaQuery.of(context).size.height - offset.dy,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                    width: 200, // Set the desired width
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder(
                            stream: widget.database
                                .select(widget.database.tasksList)
                                .watch(),
                            builder: (context, snapshot) {
                              // if (!snapshot.hasData) {
                              //   return Center(child: CircularProgressIndicator());
                              // }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child:
                                        CircularProgressIndicator()); // Loading state
                              }
                              if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                    child: Text(
                                        'Error: ${snapshot.error}')); // Error state
                              }
                              if (!snapshot.hasData || snapshot.data == null) {
                                return Center(
                                    child: Text(
                                        'No tasks available.')); // No data state
                              }

                              final newTasks = snapshot.data!;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: newTasks.length,
                                // Replace with your actual item count
                                itemBuilder: (BuildContext context, int index) {
                                  var item = newTasks[index];
                                  return ListTile(
                                    leading:
                                        SvgPicture.asset(ImagePath.taskIcon),
                                    title: Text(item.taskList),
                                    onTap: () {
                                      _overlayEntry
                                          ?.remove(); // Close the popup
                                      setState(() {
                                        selectedTaskListItem = item.taskList;
                                        selectedTaskListItemId = item.id;
                                      });

                                      preferenceManager.setValue(
                                          Constants.TASK_LIST_KEY,
                                          item.taskList);
                                      preferenceManager.setValue(
                                          Constants.TASK_LIST_ID_KEY, item.id);
                                      print(
                                          "selected task id ==> $selectedTaskListItemId");
                                      // print('Selected Item ${index + 1}');
                                    },
                                  );
                                },
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Finished",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              _overlayEntry?.remove();
                              Utils.showAddTaskDialog(context, widget.database,null);
                            },
                            child: Text("Add Task",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        );
      },
    );

    // Insert the OverlayEntry into the Overlay
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              Future.delayed(Duration(milliseconds: 200), () {
                if (value == '1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TaskListScreen(database: widget.database),
                    ),
                  );
                } else if (value == '2') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("About"),
                      content: Text("This is a sample About section."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: '1', child: Text("Task List")),
              PopupMenuItem(value: '2', child: Text("About")),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            elevation: 5,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream:
                  widget.database.watchTasksForTaskList(selectedTaskListItemId),
              builder: (context, snapshot) {
                // print(snapshot.hasData);
                print(snapshot.data);
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text("List $selectedTaskListItem is empty."));
                } else {
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
                }
              },
            ),
          ),
          Card(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        key: _buttonKey,
                        onPressed: () {
                          _showPopup(context);
                        },
                        child: Text(selectedTaskListItem,
                            style: TextStyle(fontSize: 20))),
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
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
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
                            title: drift.Value(
                              taskController.text.trim(),
                            ),
                            complete: drift.Value(false),
                            taskListId: drift.Value(selectedTaskListItemId),
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
          ))
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
