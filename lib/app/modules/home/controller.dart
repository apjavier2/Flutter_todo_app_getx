import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/app/data/services/storage/repository.dart';

import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editctrl = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  //tasks list for home page and make it observable.
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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
    editctrl.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    } else {
      var todo = {'title': title, 'done': false};
      todos.add(todo);
      //create duplicate task to modify todo list
      var newTask = task.copyWith(todos: todos);
      int oldIndex = tasks.indexOf(task);

      //replace old version with updated version
      tasks[oldIndex] = newTask;

      tasks.refresh();
      return true;
    }
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTodo(String title) {
    // bool existing = doingTodos
    //     .any((e) => e['title'] == todo['title'] && e['done'] == todo['done']);
    //alternative

    //checking in doing todos:
    var todo = {'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }

    //checking in done todos:
    var doneTodo = {'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    //create duplicate task to modify todo list
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(task.value!);

    //replace old version with updated version
    tasks[oldIndex] = newTask;

    tasks.refresh();
  }
}
