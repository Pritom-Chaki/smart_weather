import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/local_task_model.dart';

class HiveMethods extends ChangeNotifier {
  String hiveBox = 'task_local_db';

  //Adding cart model to hive db
  Future<int?> addTask(taskModel) async {
    var box = await Hive.openBox(hiveBox);

    var mapCartData = taskModel.toMap(taskModel);

    var result = await box.add(mapCartData);
    //closing the hive box
    Hive.close();
    notifyListeners();
    return result;
  }

  //Reading all the cart data
  Future<List<LocalTaskModel>> getTaskLists() async {
    var box = await Hive.openBox(hiveBox);
    List<LocalTaskModel> tasks = [];

    for (int i = 0; i < box.length; i++) {
      var taskMap = box.getAt(i);

      if (taskMap != null) {
        tasks.add(LocalTaskModel.fromMap(Map.from(taskMap)));
      }
    }
    return tasks;
  }

  //Deleting one data from hive DB
  deleteTask(int id) async {
    var box = await Hive.openBox(hiveBox);

    await box.deleteAt(id);
  }

  //Deleting whole data from Hive
  deleteAllProducts() async {
    var box = await Hive.openBox(hiveBox);
    await box.clear();
  }
}
