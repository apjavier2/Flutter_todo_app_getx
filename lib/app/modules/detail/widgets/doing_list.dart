import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/app/core/utils/extensions.dart';
import 'package:todo_app_getx/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/images/task.png',
                fit: BoxFit.cover,
                width: 50.0.wp,
              ),
            ),
            Text(
              'Add task',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
            )
          ])
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
                ...homeCtrl.doingTodos
                    .map((element) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 9.0.wp),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey),
                                    onChanged: (bool? value) {
                                      homeCtrl.doneTodo(element['title']);
                                    },
                                    value: element['done'],
                                  )),
                              SizedBox(width: 4.0.wp),
                              Text(element['title'],
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ))
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty) ...[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: const Divider(thickness: 2))
                ]
              ]));
  }
}
