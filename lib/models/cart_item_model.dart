import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  late int productId;

  @HiveField(1)
  late String productTitle;

  @HiveField(2)
  late String productThumbnail;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late int quantity;

  @HiveField(5)
  late String userId;

  @HiveField(6)
  late String category;

  @HiveField(7)
  late String brand;

  CartItem({
    required this.productId,
    required this.productTitle,
    required this.productThumbnail,
    required this.price,
    required this.quantity,
    required this.userId,
    required this.category,
    required this.brand,
  });

  double get totalPrice => price * quantity;
}
