import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reciprocal_task/controllers/product_controller.dart';
import 'package:reciprocal_task/main.dart';
import 'package:reciprocal_task/pages/products_page.dart';
import 'package:reciprocal_task/services/firestore_service.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final FirestoreService firestoreService = FirestoreService();
  final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity - 60,
          child: ElevatedButton(
              onPressed: () async {
                String name = box.read('Name') ?? '';
                firestoreService.addProducts(
                    name,
                    productController.cartProducts
                        .map((e) => e.toMap())
                        .toList());

                        productController.clearCart();
                        Get.offAll(()=>ProductsListPage());
              },
              child: const Text('Place Order'))),
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: GetBuilder<ProductController>(builder: (controllerCart) {
        return ListView.builder(
          itemCount: controllerCart.cartProducts.length,
          itemBuilder: (context, index) {
            return controllerCart.cartProducts.isEmpty
                ? const Center(
                    child: Text('No items in the cart'),
                  )
                : ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          controllerCart.cartProducts[index].image ?? ''),
                    ),
                    title: Text(controllerCart.cartProducts[index].title ?? ''),
                    subtitle: Text(controllerCart.cartProducts[index].quantity
                            .toString() ??
                        ''),
                    trailing: Text(
                        controllerCart.cartProducts[index].price.toString() ??
                            '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  );
          },
        );
      }),
    );
  }
}
