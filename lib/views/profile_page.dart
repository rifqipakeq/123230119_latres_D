import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Obx(() {
                final name = authCtrl.username.value;
                final initial =
                    name.isNotEmpty ? name[0].toUpperCase() : 'U';
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.indigo,
                      child: Text(initial,
                          style: const TextStyle(
                              fontSize: 32, color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    Text(name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      'ID: ${authCtrl.userId.value}',
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),

            const Text('Tentang',
                style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            const Text(
              'Aplikasi online shop sederhana. Data keranjang disimpan '
              'secara lokal menggunakan Hive dan dipisahkan per akun.',
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _confirmLogout(authCtrl),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(AuthController authCtrl) {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Yakin ingin keluar?',
      textConfirm: 'Keluar',
      textCancel: 'Batal',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        authCtrl.logout();
      },
    );
  }
}
