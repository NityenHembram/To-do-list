import 'package:drift/drift.dart' as drift;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key, required this.database});

  final AppDatabase database;

  @override
  State<Homepage> createState() => _HomepageState();
}
final GlobalKey _buttonKey = GlobalKey(); // To get button position
OverlayEntry? _overlayEntry;

void _showPopup(BuildContext context) {
  // Get the button's position
  final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10, // Replace with your actual item count
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item ${index + 1}'),
                      onTap: () {
                        _overlayEntry?.remove(); // Close the popup
                        print('Selected Item ${index + 1}');
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  // Insert the OverlayEntry into the Overlay
  Overlay.of(context).insert(_overlayEntry!);
}


String? selectedItem;
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
          Card(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      key:_buttonKey,
                        onPressed: () {

                          _showPopup(context);

                          // showModalBottomSheet(
                          //     context: context,
                          //     shape: const RoundedRectangleBorder( // <-- SEE HERE
                          //       borderRadius: BorderRadius.vertical(
                          //         top: Radius.circular(25.0),
                          //       ),
                          //     ),
                          //     builder: (context) {
                          //       return SizedBox(
                          //         height: 200,
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: const <Widget>[
                          //             Text('data'),
                          //             Text('data'),
                          //             Text('data'),
                          //             Text('data'),
                          //             Text('data'),
                          //             Text('data'),
                          //           ],
                          //         ),
                          //       );
                          //     });
                        },
                        child: Text('Task List')),
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
                      child: Text("+"),
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
