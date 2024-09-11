import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get/components/export.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/controllers/export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        color: kBlack,
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/logo_bootsplash.png"),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 230.h),
                child: const LoadingIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
