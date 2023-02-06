import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app_getx/app/data/services/storage/services.dart';
import 'app/modules/home/view.dart';

void main() async {
  await GetStorage.init();
  //This code will return the storage service instance
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'ToDo List using GetX Framework',
      home: HomePage(),
    );
  }
}
