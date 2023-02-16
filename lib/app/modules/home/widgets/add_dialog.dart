import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/app/core/utils/extensions.dart';

import '../controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        homeCtrl.editctrl.clear();
                        homeCtrl.changeTask(null);
                        Get.back();
                      },
                      icon: const Icon(Icons.close)),
                  TextButton(
                      //this removes the splash effect / converts it to transparent
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          if (homeCtrl.task.value == null) {
                            EasyLoading.showError('Please select a task type');
                          } else {
                            var success = homeCtrl.updateTask(
                                homeCtrl.task.value!, homeCtrl.editctrl.text);
                            if (success) {
                              EasyLoading.showSuccess('Todo item added!');
                              Get.back();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already exist');
                            }
                            homeCtrl.editctrl.clear();
                          }
                        }
                      },
                      child: Text('Done', style: TextStyle(fontSize: 14.0.sp)))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text('New Task',
                  style: TextStyle(
                      fontSize: 20.0.sp, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editctrl,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!))),
                autofocus: true,
                validator: ((value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            ...homeCtrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            children: [
                              Icon(
                                IconData(element.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(element.color),
                              ),
                              SizedBox(width: 3.0.wp),
                              Text(element.title,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              if (homeCtrl.task.value == element) ...[
                                const Icon(Icons.check, color: Colors.blue)
                              ]
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
