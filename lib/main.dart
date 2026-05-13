import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/notification_service.dart';
import 'services/cart_service.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CartService.initHive();
  await NotificationService.init();

  Get.put<AuthController>(AuthController(), permanent: true);
  Get.put<CartController>(CartController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Latihan Responso',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
