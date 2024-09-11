import 'package:flutter/material.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/controllers/todo_controller.dart';
import 'package:todolist_get/models/res/todo_res.dart';
import 'package:todolist_get/theme.dart';

Future<void> modalBottomSheet({
  required BuildContext context,
  required TextEditingController title,
  required TextEditingController description,
  required TodoController todoController,
  required Function() onPressed,
  required Function() onPressed2,
  required VoidCallback onDismiss,
  GlobalKey<FormState>? taskFormKey,
  DateTime? time,
  TodoResponse? todo,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 310.h,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: kGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Form(
              key: taskFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Task',
                        style: textStyles(18, kWhite, FontWeight.bold),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 20.h),
                  CustomTextField(
                    isTask: true,
                    controller: title,
                    hintText: 'Title',
                    keyboardType: TextInputType.text,
                    validator: (title) {
                      if (title!.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                  ),
                  HeightSpacer(height: 15.h),
                  CustomTextField(
                    isTask: true,
                    controller: description,
                    hintText: 'Description',
                    keyboardType: TextInputType.text,
                    validator: (description) {
                      if (description!.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                  ),
                  HeightSpacer(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.timer_sharp,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: onPressed2,
                        icon: const Icon(
                          Icons.send,
                          color: kPurple,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(onDismiss);
}
