import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();
    final productCtrl = Get.find<ProductController>();
    final cartCtrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Halo, ${authCtrl.username.value}')),
        actions: [
          Obx(() {
            final count = cartCtrl.itemCount;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Get.toNamed(AppRoutes.cart),
                ),
                if (count > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$count',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: productCtrl.search,
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: Obx(() => productCtrl.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: productCtrl.clearSearch,
                      )
                    : const SizedBox.shrink()),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (productCtrl.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productCtrl.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(productCtrl.errorMessage.value,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: productCtrl.fetchProducts,
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }
              if (productCtrl.filteredProducts.isEmpty) {
                return const Center(child: Text('Produk tidak ditemukan'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: productCtrl.filteredProducts.length,
                itemBuilder: (_, index) {
                  final product = productCtrl.filteredProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () =>
                        Get.toNamed(AppRoutes.detail, arguments: product),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
