import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list/Utility/preference_manager.dart';
import 'package:to_do_list/res/image_path.dart';
import 'package:to_do_list/screens/edit_task_screen.dart';
import 'package:to_do_list/screens/task_list_screen.dart';
import '../Utility/utils.dart';
import '../db/database.dart';
import 'about_screen.dart';

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
  TasksListData? selectedTaskListItem;
  String selectedTaskName = 'Default';
  var selectedTaskListItemId = 0;
  final preferenceManager = PreferenceManager();
  bool _isPopupVisible = false;

  final GlobalKey _buttonKey = GlobalKey(); // To get button position
  OverlayEntry? _overlayEntry;
  var showFinishedList = false;
  final finishedSectionName = 'Finished';

  @override
  void initState() {
    super.initState();
  }

  initialization() async {
    final taskItem = await preferenceManager.getTask();
    if (taskItem != null) {
      selectedTaskListItem = taskItem;
      selectedTaskName = selectedTaskListItem!.taskListName;
      if (selectedTaskName == finishedSectionName) {
        showFinishedList = true;
      }
      selectedTaskListItemId = selectedTaskListItem!.id;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initialization();
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
                _overlayEntry?.remove();

                setState(() {
                  _isPopupVisible = false;
                });
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
                                    title: Text(item.taskListName),
                                    trailing: FutureBuilder(
                                        future: widget.database
                                            .getTaskCount(item.id),
                                        builder: (context, snapshot) {
                                          var taskListLength = snapshot.data;
                                          return Text(
                                              taskListLength.toString());
                                        }),
                                    onTap: () {
                                      _overlayEntry
                                          ?.remove(); // Close the popup
                                      setState(() {
                                        _isPopupVisible = false;
                                        showFinishedList = false;
                                        selectedTaskListItem = item;
                                        selectedTaskName = item.taskListName;
                                        selectedTaskListItemId = item.id;
                                      });

                                      preferenceManager.saveTask(item);

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
                            onPressed: () {
                              setState(() {
                                showFinishedList = true;
                                _isPopupVisible = false;
                                selectedTaskName = finishedSectionName;
                              });
                              // preferenceManager.setValue(
                              //     Constants.TASK_LIST_KEY, finishedSectionName);
                              _overlayEntry?.remove();
                            },
                            child: Row(
                              children: [
                                Text(finishedSectionName,
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder(
                                    future:
                                        widget.database.getFinishedTaskCount(),
                                    builder: (context, snapshot) {
                                      return Text(snapshot.data.toString());
                                    })
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextButton(
                            onPressed: () {
                              _overlayEntry?.remove();
                              Utils.showAddTaskDialog(
                                  context, widget.database, null);
                              setState(() {
                                _isPopupVisible = false;
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(double.infinity,
                                  0), // ✅ This makes it full width
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Add Task",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
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
              if (value == '1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TaskListScreen(database: widget.database),
                  ),
                );
              } else if (value == '2') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              }
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
          if (showFinishedList)
            Expanded(
                child: StreamBuilder(
                    stream: widget.database
                        .select(widget.database.finishedTaskTable)
                        .watch(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("List Finished is empty."));
                      } else {
                        final finishedList = snapshot.data!;

                        return ListView.builder(
                          itemCount: finishedList.length,
                          itemBuilder: (context, index) {
                            var finishedTask = finishedList[index];

                            return Card(
                              child: FutureBuilder<String?>(
                                future: widget.database.getTaskListNameById(
                                    finishedTask.taskListId ?? 0),
                                // Pass the correct ID
                                builder: (context, snapshot) {
                                  String taskListName = snapshot.data ??
                                      'Unknown List'; // Default if null or loading

                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align text to the left
                                      children: [
                                        Text(finishedTask.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(taskListName,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                        (finishedTask.taskDateTime != null)
                                            ? Text(
                                                Utils.convertDateTimeToString(
                                                    "EEE, MMM d hh:mm a",
                                                    finishedTask.taskDateTime!),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12))
                                            : SizedBox.shrink(),
                                        // Show the task list name
                                      ],
                                    ),
                                    trailing: Checkbox(
                                      value: finishedTask.complete,
                                      onChanged: (value) {
                                        widget.database
                                            .moveToTask(finishedTask.id);
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    }))
          else
            Flexible(
              fit: FlexFit.loose,
              child: StreamBuilder<List<Task>>(
                stream: widget.database
                    .watchTasksForTaskList(selectedTaskListItemId),
                builder: (context, snapshot) {
                  // print(snapshot.hasData);
                  print(snapshot.data);
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text("List "),
                          Text(
                            selectedTaskName,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 200, 151, 6)),
                          ),
                          Text(" is empty.")
                        ]));
                  } else {
                    final newTasks = snapshot.data!;
                    return ListView.builder(
                        itemCount: newTasks.length,
                        itemBuilder: (context, index) {
                          final task = newTasks[index];
                          return _buildItem(task);
                        });
                    //
                    // print(newTasks);
                    // _updateAnimatedList(newTasks);
                    // return AnimatedList(
                    //   key: _listKey,
                    //   initialItemCount: tasks.length,
                    //   itemBuilder: (context, index, animation) {},
                    // );
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
                        setState(() {
                          _isPopupVisible =
                              !_isPopupVisible; // Toggle popup state
                        });
                        if (_isPopupVisible) {
                          _showPopup(context);
                        } else {
                          _overlayEntry?.remove(); // Close popup
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            selectedTaskName,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          AnimatedRotation(
                            turns: _isPopupVisible ? 0.5 : 0.0,
                            // Rotate icon
                            duration: Duration(milliseconds: 300),
                            // Animation duration
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(16)),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditTaskScreen(database: widget.database)));
                        if (result != null) {
                          setState(() {
                            print("in home Page $result");
                            selectedTaskListItem = result;
                            selectedTaskName =
                                (result as TasksListData).taskListName;
                            selectedTaskListItemId = result.id;
                          });
                        }
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                child: showFinishedList
                    ? SizedBox.shrink()
                    : Row(
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
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(15)),
                            onPressed: () {
                              if (taskController.text.trim().isNotEmpty) {
                                widget.database.addTask(TasksCompanion(
                                  title: drift.Value(
                                    taskController.text.trim(),
                                  ),
                                  complete: drift.Value(false),
                                  taskListId:
                                      drift.Value(selectedTaskListItemId),
                                ));
                                taskController.clear();
                              }
                            },
                            child: Image.asset(
                              ImagePath.sendIcon,
                              width: 20,
                              height: 20,
                            ),
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

  // void _updateAnimatedList(List<Task> newTasks) {
  //   final oldTasks = List<Task>.from(tasks);
  //   tasks = newTasks;

  //   // Detect additions
  //   for (var i = 0; i < tasks.length; i++) {
  //     if (i >= oldTasks.length || tasks[i] != oldTasks[i]) {
  //       _listKey.currentState
  //           ?.insertItem(i, duration: Duration(milliseconds: 300));
  //     }
  //   }

  //   // Detect deletions
  //   for (var i = 0; i < oldTasks.length; i++) {
  //     if (i >= tasks.length || oldTasks[i] != tasks[i]) {
  //       final removedTask = oldTasks[i];
  //       _listKey.currentState?.removeItem(
  //         i,
  //         (context, animation) => _buildItem(removedTask, animation),
  //         duration: Duration(milliseconds: 300),
  //       );
  //     }
  //   }
  // }

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

  Widget _buildItem(Task task) {
    final taskName = task.title;
    final taskDate = task.taskDateTime;
    final priority = task.priority;
    return Card(
      child: ListTile(
        title: Row(
          spacing: 10,
          children: [
            Text(
              task.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            (taskDate != null)
                ? Card(
                    color: prorityColor(priority),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        priorityText(priority),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
        subtitle: (taskDate != null)
            ? Text(
                Utils.convertDateTimeToString("EEE, MMM d hh:mm a", taskDate),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: taskDate.isBefore(DateTime.now())
                        ? Colors.red
                        : Colors.black),
              )
            : null,
        trailing: Checkbox(
          value: task.complete,
          onChanged: (value) {
            widget.database.moveToFinishedTask(task.id);
          },
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditTaskScreen(database: widget.database, task: task)));
        },
      ),
    );
  }

  MaterialColor? prorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.red;
    }
    return null;
  }

  String priorityText(int priority) {
    switch (priority) {
      case 1:
        return "low";
      case 2:
        return "min";
      case 3:
        return "high";
    }
    return "";
  }
}

  // Widget _buildItem(Task task, Animation<double> animation) {
  //   return SlideTransition(
  //     position: Tween<Offset>(
  //       begin: Offset(1.0, 0.0), // Start from right for adding items
  //       end: Offset.zero,
  //     ).animate(animation),
  //     child: Card(
  //       child: ListTile(
  //         title: Text(
  //           task.title,
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         trailing: Checkbox(
  //           value: task.complete,
  //           onChanged: (value) {
  //             widget.database.moveToFinishedTask(task.id);
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }

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
