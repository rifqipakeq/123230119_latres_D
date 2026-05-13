import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final Product _product;
  late final DetailController _detailCtrl;
  late final CartController _cartCtrl;

  @override
  void initState() {
    super.initState();
    _product = Get.arguments as Product;
    _detailCtrl = Get.find<DetailController>()..initProduct(_product);
    _cartCtrl = Get.find<CartController>();
  }

  void _increment() {
    _detailCtrl.increment();
    setState(() {});
  }

  void _decrement() {
    _detailCtrl.decrement();
    setState(() {});
  }

  void _addToCart() {
    _cartCtrl.addToCart(_product, _detailCtrl.quantity.value);
    Get.snackbar(
      'Berhasil',
      '${_product.title} ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qty = _detailCtrl.quantity.value;

    return Scaffold(
      appBar: AppBar(title: Text(_product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Center(
              child: Image.network(
                _product.thumbnail,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 80),
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : const SizedBox(
                        height: 220,
                        child: Center(child: CircularProgressIndicator())),
              ),
            ),
            const SizedBox(height: 16),

            Text(_product.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Text(
              '\$${_product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 8),

            // Info table
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                _row('Brand', _product.brand),
                _row('Kategori', _product.category),
                _row('Stok', '${_product.stock} pcs'),
                _row('Rating', '⭐ ${_product.rating.toStringAsFixed(1)}'),
                _row('Diskon',
                    '${_product.discountPercentage.toStringAsFixed(1)}%'),
              ],
            ),
            const SizedBox(height: 12),

            const Text('Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(_product.description),
            const SizedBox(height: 24),

            const Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: qty > 1 ? _decrement : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$qty',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: qty < _product.stock ? _increment : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
                Text('(Maks. ${_product.stock})',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Tambah ke Keranjang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _row(String label, String value) => TableRow(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text('$label : ',
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(value),
        ),
      ]);
}
