import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../services/cart_service.dart';
import '../services/notification_service.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble totalPrice = 0.0.obs;

  String _userId = '';

  void init(String userId) {
    _userId = userId;
    loadCart();
  }

  void clear() {
    _userId = '';
    cartItems.clear();
    totalPrice.value = 0.0;
  }

  void loadCart() {
    cartItems.assignAll(CartService.getCartItems(_userId));
    totalPrice.value =
        cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> addToCart(Product product, int quantity) async {
    final item = CartItem(
      productId: product.id,
      productTitle: product.title,
      productThumbnail: product.thumbnail,
      price: product.price,
      quantity: quantity,
      userId: _userId,
      category: product.category,
      brand: product.brand,
    );

    await CartService.addToCart(item);
    loadCart();
    await NotificationService.onAddToCart(product.title, quantity);
  }

  Future<void> removeFromCart(dynamic hiveKey) async {
    await CartService.removeFromCart(hiveKey);
    loadCart();
  }

  int get itemCount => cartItems.length;
}
