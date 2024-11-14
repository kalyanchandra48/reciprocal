import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reciprocal_task/controllers/product_controller.dart';
import 'package:reciprocal_task/models/product.dart';
import 'package:reciprocal_task/pages/cart_page.dart';

ValueNotifier<int> cartCount = ValueNotifier<int>(0);

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 400,
                        child: Image.network(product.image.toString())),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.description.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Price: \$${product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder<int>(
                    valueListenable: cartCount,
                    builder: (context, cartVal, snapshot) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: cartVal == 0
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartCount.value++;
                                    productController.addToCart(product);
                                  },
                                  child: const Text('Add to cart'),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  // Add the product to the cart
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          cartCount.value++;
                                          productController.addToCart(product);
                                        },
                                        child: const Icon(Icons.add)),
                                    const SizedBox(width: 35),
                                    Text(cartVal.toString(),
                                        style: const TextStyle(fontSize: 24)),
                                    const SizedBox(width: 35),
                                    InkWell(
                                        onTap: () {
                                          cartCount.value--;
                                          productController
                                              .removeFromCart(product);
                                        },
                                        child: const Icon(Icons.remove)),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                          Get.to(() => CartPage());
                                        },
                                        child: const Icon(Icons.shopping_cart)),
                                  ],
                                ),
                              ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
