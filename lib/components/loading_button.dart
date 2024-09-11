import 'package:flutter/material.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    this.onPressed,
  });

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
        child: const LoadingIndicator(isButton: true),
      ),
    );
  }
}
