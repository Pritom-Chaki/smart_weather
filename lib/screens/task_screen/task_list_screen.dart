import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/local_task_model.dart';
import '../../utils/constant_data.dart';
import '../../utils/local_storage/hive_methods.dart';
import 'task_component.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<LocalTaskModel> tasks = [];
  @override
  void initState() {
    _getTaskList();
    super.initState();
  }

  void _getTaskList() {
    HiveMethods().getTaskLists().then((value) {
      setState(() {
        tasks = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog(context);
        },
        child: const Icon(
          Icons.add_task,
          color: Colors.blue,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getTaskList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(AppConstant.onBackImg2))),
          child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (c, i) {
                return Dismissible(
                    key: Key(tasks[i].task),
                    onDismissed: (direction) {
                      setState(() {});
                      HiveMethods().deleteTask(i);
                      _getTaskList();
                    },
                    background: const Row(
                      children: [
                        Icon(
                          Icons.done_outline,
                          color: Colors.green,
                        ),
                        Text(
                          "Task Done",
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                    secondaryBackground: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    child: TaskComponent(
                      task: tasks[i],
                    ));
              }),
        ),
      ),
    );
  }

  Future<void> _addTaskDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Center(child: Text("Add Your Task")),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Can not be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Task",
                          prefixIcon: Icon(Icons.task),
                          prefixIconColor: Colors.blue),
                    ),
                    TextFormField(
                      controller: _locationController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Can not be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: "Location",
                          prefixIcon: Icon(Icons.location_on),
                          prefixIconColor: Colors.red),
                    ),
                    TextFormField(
                        controller: _dateController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Field Can not be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Date",
                            prefixIcon: Icon(Icons.calendar_today),
                            prefixIconColor: Colors.orange),
                        readOnly: true,
                        onTap: () async {
                          _datePicker();
                        }),
                    TextFormField(
                      controller: _detailsController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Field Can not be empty";
                        }
                        return null;
                      },
                      minLines: 3,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          label: Text("Details"),
                          prefixIcon: Icon(Icons.details),
                          prefixIconColor: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _clear();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                )),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTask();
                  }
                  Navigator.of(context).pop();
                },
                child:
                    const Text("Save", style: TextStyle(color: Colors.green))),
          ],
        );
      },
    );
  }

  _datePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      debugPrint(pickedDate.toString());
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      debugPrint(formattedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    } else {
      debugPrint("Date is not selected");
    }
  }

  _clear() {
    _nameController.clear();
    _locationController.clear();
    _dateController.clear();
    _detailsController.clear();
  }

  _addTask() {
    HiveMethods().addTask(LocalTaskModel(
        task: _nameController.text.trim(),
        location: _locationController.text.trim(),
        date: DateTime.parse(_dateController.text.trim()),
        details: _detailsController.text.trim(),
        createDate: DateTime.now()));
    _getTaskList();

    _clear();
  }
}
