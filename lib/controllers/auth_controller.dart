import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_get/models/req/auth_req.dart';
import 'package:todolist_get/models/res/auth_res.dart';
import 'package:todolist_get/services/auth_service.dart';
import 'package:todolist_get/theme.dart';
import 'package:todolist_get/utils/export.dart';
import 'package:todolist_get/views/export.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var authResponse = Rxn<AuthResponse>();
  var isAuthenticated = false.obs;
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  bool validateForm() {
    return loginFormKey.currentState!.validate();
  }

  bool validateFormRegister() {
    return registerFormKey.currentState!.validate();
  }

  Future<void> login(AuthRequest model) async {
    try {
      isLoading(true);
      bool success = await _authService.login(model);
      if (success) {
        isAuthenticated(true);
        Get.offAll(
          () => const BottomNavigation(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      }
    } catch (e) {
      isAuthenticated(false);
      Get.snackbar(
        "Login Failed",
        "Please check your username and password",
        colorText: kWhite,
        backgroundColor: kRed,
        icon: const Icon(Icons.add_alert, color: kWhite),
        duration: const Duration(milliseconds: 2000),
      );
      print("Login error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> register(AuthRequest model) async {
    try {
      isLoading(true);
      bool success = await _authService.register(model);
      if (success) {
        isAuthenticated(true);
        Get.offAll(
          () => LoginScreen(),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 100),
        );
      }
    } catch (e) {
      isAuthenticated(false);
      Get.snackbar(
        "Register Failed",
        "Username is not available",
        colorText: kWhite,
        backgroundColor: kRed,
        icon: const Icon(Icons.add_alert, color: kWhite),
        duration: const Duration(milliseconds: 2000),
      );
      print("Register error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> authMe() async {
    String? username = await UserPreferences().getUsername();
    try {
      isLoading(true);
      await _authService.me(username!);
    } catch (e) {
      print("Login error: $e");
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    isAuthenticated(false);
    authResponse.value = null;
  }
}
