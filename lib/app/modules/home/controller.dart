import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/app/data/services/storage/repository.dart';

import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editctrl = TextEditingController();
  //tasks list for home page and make it observable.
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    //this will read all the tasks in the storage and assign it to tasks list.
    tasks.assignAll(taskRepository.readTasks());

    //This function will be called whenever there is a change in the tasks.
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
