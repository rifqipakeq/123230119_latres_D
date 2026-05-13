import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item_model.dart';

class CartService {
  static const String _boxName = 'cart_box';

  static Box<CartItem> get _box => Hive.box<CartItem>(_boxName);

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>(_boxName);
  }

  static List<CartItem> getCartItems(String userId) {
    return _box.values.where((item) => item.userId == userId).toList();
  }

  static Future<void> addToCart(CartItem newItem) async {
    final allItems = _box.values.toList();
    final existingIndex = allItems.indexWhere(
      (item) =>
          item.productId == newItem.productId && item.userId == newItem.userId,
    );

    if (existingIndex != -1) {
      final key = _box.keyAt(existingIndex);
      final existing = _box.get(key)!;
      existing.quantity += newItem.quantity;
      await existing.save();
    } else {
      await _box.add(newItem);
    }
  }

  static Future<void> removeFromCart(dynamic key) async {
    await _box.delete(key);
  }

  static double getCartTotal(String userId) {
    return getCartItems(userId)
        .fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}
