import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/views/export.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo List',
          theme: ThemeData(
            scaffoldBackgroundColor: kBlack,
            iconTheme: const IconThemeData(color: kDarkGrey),
            primarySwatch: Colors.grey,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
