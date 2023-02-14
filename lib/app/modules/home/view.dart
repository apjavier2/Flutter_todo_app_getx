import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/app/core/values/colors.dart';
import 'package:todo_app_getx/app/data/models/task.dart';
import 'package:todo_app_getx/app/modules/home/controller.dart';
import 'package:todo_app_getx/app/core/utils/extensions.dart';
import 'package:todo_app_getx/app/modules/home/widgets/add_card.dart';
import 'package:todo_app_getx/app/modules/home/widgets/add_dialog.dart';

import 'widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
          children: [
            //sp extension is used for auto resizing of the text size
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text('My List',
                  style: TextStyle(
                      fontSize: 24.0.sp, fontWeight: FontWeight.bold)),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map((element) => LongPressDraggable(
                          data: element,
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(false),
                          onDragEnd: (_) => controller.changeDeleting(false),
                          feedback: Opacity(
                              opacity: 0.8, child: TaskCard(task: element)),
                          child: TaskCard(task: element)))
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        )),
        floatingActionButton: DragTarget<Task>(
          onAccept: (Task task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Delete success');
          },
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                onPressed: () =>
                    Get.to(() => AddDialog(), transition: Transition.downToUp),
                backgroundColor:
                    controller.deleting.value == true ? Colors.red : blue,
                child: Icon(controller.deleting.value == true
                    ? Icons.delete
                    : Icons.add),
              ),
            );
          },
        ));
  }
}
