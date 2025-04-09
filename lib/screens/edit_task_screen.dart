import 'dart:ffi';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_list/Utility/constants.dart';
import 'package:to_do_list/Utility/preference_manager.dart';
import 'package:to_do_list/Utility/utils.dart';
import 'package:to_do_list/db/database.dart';
import 'package:to_do_list/services/notification_service.dart';
import 'package:to_do_list/themes/extentions.dart';
import 'package:to_do_list/widgets/custom_text_field.dart';

class EditTaskScreen extends StatefulWidget {
  final AppDatabase database;
  final Task? task;
  const EditTaskScreen({super.key, required this.database, this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  int selectedPrority = 1;

  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();

  String selectedDate = '';
  String selectedTime = '';

  DateTime? rawDateTime;

  List<TasksListData> dropdownTaskList = [];
  TasksListData selectedTask =
      TasksListData(id: 1, taskListName: "Default", isDeleteAble: false);
  PreferenceManager pm = PreferenceManager();
  TextEditingController taskNameContoller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isDateTimeSelectionEnable = false;

  final NotificationService _notificationService = NotificationService();

  Task? taskDetails;

  @override
  void initState() {
    super.initState();
    init();
    _requestExactAlarmPermission();
  }

  setTaskDetails() {
    setState(() {
      taskNameContoller.text = taskDetails!.title;
      DateTime? taskDateTime = taskDetails!.taskDateTime;
      if (taskDateTime != null) {
        selectedDate = Utils.convertDateTimeToString(
            Constants.DISPLAY_DATE_FORMAT, taskDateTime);
        selectedTime = Utils.convertDateTimeToString(
            Constants.DISPLAY_TIME_FORMAT, taskDateTime);
        rawDateTime = taskDateTime;
        isDateTimeSelectionEnable = true;
        selectedPrority = taskDetails!.priority;
      }
    });
  }

  Future<void> init() async {
    await _notificationService.init();
  }

  initializeData() async {
    final tasklist = await pm.getValue(Constants.TASK_LIST_KEY);
    if (tasklist != null) {
      selectedTask = tasklist;
    }
  }

  Future<void> _requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      var status = await Permission.scheduleExactAlarm.request();
      if (status.isGranted) {
        print('Exact alarm permission granted');
      } else if (status.isDenied) {
        print('Exact alarm permission denied. Some features may not work.');
      } else if (status.isPermanentlyDenied) {
        openAppSettings(); // Open settings if permanently denied
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setCurrentDate();
  }

  setCurrentDate() {
    taskDetails = widget.task;
    if (taskDetails != null) {
      setTaskDetails();
    } else {
      selectedDate =
          Utils.convertDateToString(Constants.DISPLAY_DATE_FORMAT, currentDate);
      selectedTime = Utils.convertTimeToString(
          Constants.DISPLAY_TIME_FORMAT, currentTime.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            validateFields();
          },
          child: Icon(Icons.done),
        )

        // Padding(
        //     padding: EdgeInsets.all(5),
        //     child:Ge Card(
        //         color: Colors.amber,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.all(Radius.circular(5))),
        //         child: Padding(
        //           padding: EdgeInsets.all(10),
        //           child: Icon(Icons.done),
        //         )))
        ,
        appBar: AppBar(
          title: Text("Edit Task"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                "What is to be done?",
                style: context.title,
              ),
              CustomTextField(
                labelText: "Enter Task Here",
                controller: taskNameContoller,
                focusNode: focusNode,
              ),
              Row(
                spacing: 10,
                children: [
                  Text(
                    "Due date",
                    style: context.title,
                  ),
                  FlutterSwitch(
                      value: isDateTimeSelectionEnable,
                      width: 45.0,
                      height: 28.0,
                      activeColor: Color.fromARGB(255, 31, 5, 98),
                      onToggle: (isEnable) {
                        setState(() {
                          isDateTimeSelectionEnable = isEnable;
                          rawDateTime = DateTime(
                              currentDate.year,
                              currentDate.month,
                              currentDate.day,
                              currentTime.hour,
                              currentTime.minute);
                        });
                      })
                ],
              ),
              !isDateTimeSelectionEnable
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [datePickerWidget(), timePickerWidget()],
                    ),
              !isDateTimeSelectionEnable
                  ? SizedBox.shrink()
                  : Text(
                      "Priority",
                      style: context.title,
                    ),
              !isDateTimeSelectionEnable
                  ? SizedBox.shrink()
                  : customRadioGroup(),
              Text(
                "Tasks",
                style: context.title,
              ),
              dropDownButton()
            ],
          ),
        ));
  }

  validateFields() async {
    final taskField = taskNameContoller.text.trim();

    if (taskField.isEmpty) {
      focusNode.requestFocus();
    } else {
      print(
          "task Name = $taskField Priority = $selectedPrority   task = $selectedTask ");
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
      final Task? task = widget.task;
      if (task == null) {
        saveTask(taskField);
      } else {
        updateTask(taskField, task);
      }
    }
  }

  saveTask(
    String taskField,
  ) async {
    if (!isDateTimeSelectionEnable) {
      widget.database.addTask(TasksCompanion(
        title: drift.Value(
          taskField,
        ),
        complete: drift.Value(false),
        taskListId: drift.Value(selectedTask.id),
      ));
      taskNameContoller.clear();
      Navigator.pop(context, selectedTask);
    } else {
      // DateTime reminderDate =
      //     rawDateTime!.subtract(const Duration(minutes: 5));

      Priority notificationPrioriry = Priority.low;
      switch (selectedPrority) {
        case 1:
          notificationPrioriry = Priority.low;
        case 2:
          notificationPrioriry = Priority.min;
        case 3:
          notificationPrioriry = Priority.high;
      }
      if (rawDateTime!.isAfter(DateTime.now())) {
        await _notificationService.scheduleNotification(
            id: selectedTask.id,
            title: "Task due : ${taskNameContoller.text}",
            body:
                "Is due at ${Utils.convertDateTimeToString("EEE, MMM d hh:mm a", rawDateTime!)}",
            scheduledDate: rawDateTime!,
            priority: notificationPrioriry);

        widget.database.addTask(TasksCompanion(
          title: drift.Value(
            taskField,
          ),
          complete: drift.Value(false),
          taskDateTime: drift.Value(rawDateTime),
          priority: drift.Value(selectedPrority),
          taskListId: drift.Value(selectedTask.id),
        ));
        taskNameContoller.clear();
        Navigator.pop(context, selectedTask);
      }

      print(
          "task Name = $taskField Priority = $selectedPrority   Date = $currentDate  Time = $currentTime");
    }
  }

  updateTask(String taskField, Task task) async {
    if (!isDateTimeSelectionEnable) {
      widget.database.updateTask(
          task.id,
          TasksCompanion(
            title: drift.Value(
              taskField,
            ),
            complete: drift.Value(false),
            taskListId: drift.Value(selectedTask.id),
          ));
      taskNameContoller.clear();
      Navigator.pop(context, selectedTask);
    } else {
      // DateTime reminderDate =
      //     rawDateTime!.subtract(const Duration(minutes: 5));

      Priority notificationPrioriry = Priority.low;
      switch (selectedPrority) {
        case 1:
          notificationPrioriry = Priority.low;
        case 2:
          notificationPrioriry = Priority.min;
        case 3:
          notificationPrioriry = Priority.high;
      }
      if (rawDateTime!.isAfter(DateTime.now())) {
        await _notificationService.scheduleNotification(
            id: selectedTask.id,
            title: "Task due : ${taskNameContoller.text}",
            body:
                "Is due at ${Utils.convertDateTimeToString("EEE, MMM d hh:mm a", rawDateTime!)}",
            scheduledDate: rawDateTime!,
            priority: notificationPrioriry);

        widget.database.updateTask(
            task.id,
            TasksCompanion(
              title: drift.Value(
                taskField,
              ),
              complete: drift.Value(false),
              taskDateTime: drift.Value(rawDateTime),
              priority: drift.Value(selectedPrority),
              taskListId: drift.Value(selectedTask.id),
            ));
        taskNameContoller.clear();
        Navigator.pop(context, selectedTask);
      }

      print(
          "task Name = $taskField Priority = $selectedPrority   Date = $currentDate  Time = $currentTime");
    }
  }

  Map<String, int> priorityList = {'Low': 1, 'Mid': 2, 'High': 3};
  Widget customRadioGroup() {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: priorityList.entries.map((entry) {
        return CustomRadioButton(entry.key, entry.value);
      }).toList(),
    ));
  }

  Widget datePickerWidget() {
    return Expanded(
        child: GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        color: const Color.fromARGB(221, 206, 220, 11),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Center(
              child: Text(
            selectedDate,
            style: TextStyle(
                color: const Color.fromARGB(255, 6, 8, 17),
                fontSize: 15,
                fontWeight: FontWeight.w600),
          )),
        ),
      ),
      onTap: () {
        datePicker();
      },
    ));
  }

  Widget timePickerWidget() {
    return Expanded(
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: Colors.deepOrangeAccent,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                  child: Text(
                selectedTime,
                style: TextStyle(
                    color: const Color.fromARGB(255, 6, 8, 17),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ))),
        ),
        onTap: () {
          datePicker();
        },
      ),
    );
  }

  Widget dropDownButton() {
    return StreamBuilder(
      stream: widget.database.select(widget.database.tasksList).watch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (!snapshot.hasData && snapshot.data == null) {
          return Text('No Data');
        }

        final taskList = snapshot.data;
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF5F0A87), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<TasksListData>(
              value: selectedTask,
              onChanged: (TasksListData? newValue) {
                if (newValue != null) {
                  // Handle the selected task list (e.g., update UI or state)
                  print('Selected task list: ${newValue.taskListName}');
                  setState(() {
                    selectedTask = newValue;
                  });
                  // You can add setState or a state management solution here
                  // setState(() {
                  //   selectedTaskList = newValue;
                  // });
                }
              },
              dropdownColor: const Color.fromARGB(
                  225, 235, 230, 230), // Background color of the dropdown
              icon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 18, 2, 2)), // Custom dropdown icon
              iconSize: 24, // Size of the dropdown icon
              elevation: 8, // Elevation for a shadow effect
              style: const TextStyle(
                color: Color.fromARGB(255, 16, 2, 2), // Text color
                fontSize: 16, // Font size
                fontWeight: FontWeight.w500, // Font weight
              ),

              isExpanded:
                  true, // Makes the dropdown expand to fill available width
              hint: const Text(
                'Select a Task List',
                style: TextStyle(
                    color: Color.fromARGB(179, 22, 11, 11),
                    fontStyle: FontStyle.italic),
              ), // Placeholder text when no value is selected
              items: taskList?.map<DropdownMenuItem<TasksListData>>(
                      (TasksListData value) {
                    return DropdownMenuItem<TasksListData>(
                      value: value,
                      child: Row(
                        children: [
                          const Icon(Icons.list,
                              color: Color.fromARGB(255, 14, 10, 10),
                              size: 20), // Icon for each item
                          const SizedBox(
                              width: 10), // Spacing between icon and text
                          Text(
                            value.taskListName,
                            overflow: TextOverflow.ellipsis, // Handle long text
                          ),
                        ],
                      ),
                    );
                  }).toList() ??
                  [],
            ));
      },
    );
  }

  void datePicker() async {
    DateTime? pickDate = await showDatePicker(
        context: context, firstDate: DateTime(2025), lastDate: DateTime(2030));
    if (pickDate != null) {
      await timePicker(pickDate);
      setState(() {
        selectedDate = Utils.formateDateAndTime(Constants.DISPLAY_DATE_FORMAT,
            date: pickDate.toString());

        debugPrint(selectedDate);
      });
    }
  }

  Future<void> timePicker(DateTime pickedDate) async {
    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: currentTime);
    if (timeOfDay != null) {
      if (context.mounted) {
        setState(() {
          String time = timeOfDay.format(context);
          selectedTime = Utils.formateDateAndTime(Constants.DISPLAY_TIME_FORMAT,
              time: time);
          rawDateTime = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, timeOfDay.hour, timeOfDay.minute);
          debugPrint(selectedTime);
        });
      }
    }
  }

  Widget CustomRadioButton(String label, int value) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Radio(
        value: value,
        groupValue: selectedPrority,
        onChanged: (value) {
          setState(() {
            if (value != null) {
              selectedPrority = value;
              debugPrint("$selectedPrority");
            }
          });
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      Text(
        label,
        style: context.lableSmall,
      )
    ]);
  }
}
