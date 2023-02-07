import 'dart:convert';

import 'package:todo_app_getx/app/core/utils/keys.dart';
import 'package:todo_app_getx/app/data/services/storage/services.dart';
import 'package:get/get.dart';

import '../../models/task.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTasks(){
    var tasks = <Task>[];
    //This will read the tasks in the local storage using the taskKey and add it to the list:
    jsonDecode(_storage.read(taskKey).toString()).forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    //jsonEncode by default will call the toJson in our Task model
    _storage.write(taskKey, jsonEncode(tasks));
  }
}