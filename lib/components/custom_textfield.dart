import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
    this.validator,
    this.inputFormatters,
    this.isTask,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isTask;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      maxLines: 1,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: isTask == true ? kGrey : kDarkGrey,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: textStyles(14,
            isTask == true ? kWhite.withOpacity(0.5) : kGrey, FontWeight.w500),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: kWhite, width: 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Color(kDarkGrey.value), width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: kWhite, width: 0.5),
        ),
        border: InputBorder.none,
      ),
      controller: controller,
      cursorHeight: 25,
      style: textStyles(14, kWhite, FontWeight.w500),
      validator: validator,
    );
  }
}
