import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/theme.dart';

void showCustomDialog({
  required String content,
  String confirmText = "Yes",
  String cancelText = "No",
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  Get.dialog(
    AlertDialog(
      content: Text(
        content,
        style: textStyles(14, kWhite, FontWeight.w700),
      ),
      backgroundColor: kGrey,
      actions: [
        SizedBox(
          width: 80.w,
          height: 30.h,
          child: ElevatedButton(
            onPressed: onCancel ?? () => Get.back(),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(kGrey),
              side: WidgetStateProperty.all<BorderSide>(
                  const BorderSide(color: kPurple)),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
            ),
            child: Text(
              cancelText,
              style: textStyles(12, kPurple, FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          width: 80.w,
          height: 30.h,
          child: ElevatedButton(
            onPressed: onConfirm ?? () => Get.back(),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(kPurple),
              side: WidgetStateProperty.all<BorderSide>(
                  const BorderSide(color: kPurple)),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
            ),
            child: Text(
              confirmText,
              style: textStyles(12, kWhite, FontWeight.w700),
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
