import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString username = ''.obs;
  final RxString userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    isLoading.value = true;
    try {
      if (await AuthService.isLoggedIn()) {
        username.value = await AuthService.getUsername() ?? '';
        userId.value = await AuthService.getUserId() ?? '';
        _initCart();
        Get.offAllNamed(AppRoutes.home);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _initCart() {
    Get.find<CartController>().init(userId.value);
  }

  Future<void> register(String usernameInput, String password) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      final err = await AuthService.register(usernameInput, password);
      if (err != null) {
        errorMessage.value = err;
        return;
      }
      // Auto-login after register
      await _doLogin(usernameInput, password);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String usernameInput, String password) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await _doLogin(usernameInput, password);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _doLogin(String usernameInput, String password) async {
    final err = await AuthService.login(usernameInput, password);
    if (err != null) {
      errorMessage.value = err;
      return;
    }
    username.value = usernameInput.trim();
    userId.value = AuthService.toUserId(usernameInput);
    _initCart();
    await NotificationService.onLogin(username.value);
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> logout() async {
    await AuthService.logout();
    await NotificationService.onLogout();
    Get.find<CartController>().clear();
    username.value = '';
    userId.value = '';
    Get.offAllNamed(AppRoutes.login);
  }
}
