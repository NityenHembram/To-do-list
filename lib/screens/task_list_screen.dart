import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/Utility/utils.dart';
import 'package:to_do_list/res/image_path.dart';
import '../db/database.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.database});

  final AppDatabase database;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task Lists'),
          actions: [
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                Utils.showAddTaskDialog(context, widget.database,null);
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder(
                stream:
                    widget.database.select(widget.database.tasksList).watch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator()); // Loading state
                  }
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(
                        child: Text('Error: ${snapshot.error}')); // Error state
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                        child: Text('No List available.')); // No data state
                  }

                  final listData = snapshot.data!;

                  return ListView.builder(
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        var listItem = listData[index];
                        return Card(
                            child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(ImagePath.taskIcon),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    listItem.taskList,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Utils.showAddTaskDialog(context, widget.database,listItem);
                                    },
                                    child: SvgPicture.asset(ImagePath.editIcon),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Utils.showDeleteDialog(
                                          context, listItem, widget.database);
                                    },
                                    child:
                                        SvgPicture.asset(ImagePath.deleteIcon),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ));
                      });
                })));
  }
}
