import 'package:get/get.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';
import '../views/main_page.dart';
import '../views/detail_page.dart';
import '../views/cart_page.dart';
import '../routes/app_routes.dart';
import '../controllers/product_controller.dart';
import '../controllers/detail_controller.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProductController>(() => ProductController());
      }),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
      binding: BindingsBuilder(() {
        Get.put<DetailController>(DetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartPage(),
    ),
  ];
}
