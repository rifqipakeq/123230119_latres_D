import 'package:get/get.dart';
import '../models/product_model.dart';

class DetailController extends GetxController {
  final RxInt quantity = 1.obs;
  late Product product;

  void initProduct(Product p) {
    product = p;
    quantity.value = 1;
  }

  void increment() {
    if (quantity.value < product.stock) {
      quantity.value++;
    }
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
