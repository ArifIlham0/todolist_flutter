import 'package:flutter/material.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
  });

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: kWhite,
          backgroundColor: kPurple,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 5,
        ),
        child: Text(text!, style: textStyles(17, kWhite, FontWeight.normal)),
      ),
    );
  }
}
