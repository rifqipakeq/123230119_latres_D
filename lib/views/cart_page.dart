import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_item_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCtrl = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Obx(() {
        if (cartCtrl.cartItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 64, color: Colors.grey),
                SizedBox(height: 12),
                Text('Keranjang masih kosong'),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartCtrl.cartItems.length,
                itemBuilder: (_, index) {
                  final CartItem item = cartCtrl.cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    child: ListTile(
                      leading: Image.network(
                        item.productThumbnail,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                      title: Text(
                        item.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                      subtitle: Text(
                        '\$${item.price.toStringAsFixed(2)} × ${item.quantity}'
                        ' = \$${item.totalPrice.toStringAsFixed(2)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => cartCtrl.removeFromCart(item.key),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Total bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total (${cartCtrl.itemCount} item)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${cartCtrl.totalPrice.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
