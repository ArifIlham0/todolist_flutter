import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/controllers/export.dart';
import 'package:todolist_get/models/req/auth_req.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/views/export.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Form(
              key: authController.loginFormKey,
              child: Column(
                children: [
                  HeightSpacer(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: textStyles(30, kWhite, FontWeight.normal),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: textStyles(15, kWhite, FontWeight.normal),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 5.h),
                  CustomTextField(
                    controller: username,
                    hintText: "Username",
                    keyboardType: TextInputType.name,
                    validator: (username) {
                      if (username!.isEmpty || username.length < 3) {
                        return "Username harus lebih dari 3";
                      } else {
                        return null;
                      }
                    },
                  ),
                  HeightSpacer(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: textStyles(15, kWhite, FontWeight.normal),
                      ),
                    ],
                  ),
                  HeightSpacer(height: 5.h),
                  Obx(
                    () => CustomTextField(
                      controller: password,
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      obscureText: authController.obscureText.value,
                      validator: (password) {
                        if (password!.isEmpty || password.length < 7) {
                          return "Password tidak boleh kosong dan harus lebih dari 7";
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          authController.toggleObscureText();
                        },
                        icon: Icon(
                          authController.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ),
                  HeightSpacer(height: 50.h),
                  Obx(
                    () => authController.isLoading.value
                        ? LoadingButton(onPressed: () {})
                        : CustomButton(
                            onPressed: () {
                              if (authController.validateForm()) {
                                authController.login(AuthRequest(
                                  username: username.text,
                                  password: password.text,
                                ));
                              }
                            },
                            text: "Login",
                          ),
                  ),
                  HeightSpacer(height: 10.h),
                  TextButton(
                    onPressed: () {
                      Get.offAll(
                        () => RegisterScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 100),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: kWhite,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: textStyles(12, kWhite, FontWeight.normal),
                        ),
                        Text(
                          "Daftar",
                          style: textStyles(12, kWhite, FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
