import 'package:get/get.dart';
import 'package:todolist_get/services/auth_service.dart';
import 'package:todolist_get/utils/export.dart';
import 'package:todolist_get/views/export.dart';

class SplashController extends GetxController {
  final AuthService _authService = AuthService();
  final UserPreferences _userPreferences = UserPreferences();

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    bool isSuccessful = await fetchMe();

    if (isSuccessful) {
      Get.offAll(
        () => const BottomNavigation(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    } else {
      await _userPreferences.logout();
      Get.offAll(
        () => LoginScreen(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  Future<bool> fetchMe() async {
    String? username = await _userPreferences.getUsername();
    return await _authService.me(username ?? "username");
  }
}
