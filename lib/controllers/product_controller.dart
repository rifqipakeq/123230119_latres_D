import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    ever(searchQuery, _filterProducts);
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((p) =>
            p.title.toLowerCase().contains(query.toLowerCase()) ||
            p.category.toLowerCase().contains(query.toLowerCase()) ||
            p.brand.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _service.getProducts(limit: 100);
      products.assignAll(result);
      filteredProducts.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Gagal memuat produk.';
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchQuery.value = '';
  }
}
