import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/app/core/utils/extensions.dart';
import 'package:todo_app_getx/app/core/values/colors.dart';
import 'package:todo_app_getx/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2.0.wp, horizontal: 5.0.wp),
                  child: Text(
                    'Completed(${homeCtrl.doneTodos.length})',
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map((element) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 9.0.wp),
                          child: Row(
                            children: [
                              const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(Icons.done, color: blue)),
                              SizedBox(width: 4.0.wp),
                              Text(element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough))
                            ],
                          ),
                        ))
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty) ...[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: const Divider(thickness: 2))
                ]
              ])
        : const Text(''));
  }
}
