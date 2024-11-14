import 'package:get/get.dart';
import 'package:reciprocal_task/models/product.dart';
import 'package:reciprocal_task/services/products_service.dart';

class ProductController extends GetxController {
  List<Product> products = [];

  List<Product> cartProducts = [];

  ProductsService productsService = ProductsService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void clearCart(){
    cartProducts.clear();
    update();
  }

  void updateQuantity(Product product) {
    cartProducts.firstWhere((element) => element.id == product.id).quantity =
        cartProducts
                .firstWhere((element) => element.id == product.id)
                .quantity +
            1;
    update();
  }

  void initialUpdate(Product product) {
    cartProducts.add(product.copyWith(quantity: 1));
    update();
  }

  void decreaseQuantity(Product product) {
    cartProducts.firstWhere((element) => element.id == product.id).quantity =
        cartProducts
                .firstWhere((element) => element.id == product.id)
                .quantity -
            1;
    update();
  }

  void addToCart(Product product) {
    cartProducts.any((element) => element.id == product.id)
        ? updateQuantity(product)
        : initialUpdate(product);
    update();
  }

  void removeFromCart(Product product) {
    decreaseQuantity(product);
    update();
  }

  void fetchProducts() {
    productsService.getProducts().then((products) {
      this.products = products;
      update();
    });
  }
}
