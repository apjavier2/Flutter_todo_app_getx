import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_app_getx/app/modules/home/controller.dart';
import 'package:todo_app_getx/app/core/utils/extensions.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Row(
              children: [
                IconButton(
                    onPressed: (() {
                      Get.back();
                      homeCtrl.changeTask(null);
                    }),
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
            child: Row(
              children: [
                Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color),
                SizedBox(width: 3.0.wp),
                Text(task.title,
                    style: TextStyle(
                        fontSize: 12.0.sp, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Obx(() {
            var totalTodos =
                homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
            return Padding(
              padding:
                  EdgeInsets.only(left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
              child: Row(
                children: [
                  Text('$totalTodos Tasks',
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey)),
                  SizedBox(width: 3.0.wp),
                  Expanded(
                      child: StepProgressIndicator(
                    totalSteps: totalTodos == 0 ? 1 : totalTodos,
                    currentStep: homeCtrl.doneTodos.length,
                    size: 5,
                    padding: 0,
                    selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.5), color]),
                    unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey[300]!, Colors.grey[300]!]),
                  ))
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
