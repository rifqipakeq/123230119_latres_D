import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'shop_channel';
  static const _channelName = 'Shop Notifications';

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);
  }

  static Future<void> show(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    );

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }


  static Future<void> onLogin(String username) =>
      show('Login Berhasil', 'Selamat datang, $username!');

  static Future<void> onLogout() =>
      show('Logout', 'Anda telah keluar dari akun.');

  static Future<void> onAddToCart(String productName, int qty) =>
      show('Ditambahkan ke Keranjang', '$productName (x$qty)');
}
