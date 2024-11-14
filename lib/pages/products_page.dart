import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reciprocal_task/controllers/product_controller.dart';
import 'package:reciprocal_task/main.dart';
import 'package:reciprocal_task/models/product.dart';
import 'package:reciprocal_task/pages/cart_page.dart';
import 'package:reciprocal_task/pages/login_screen.dart';
import 'package:reciprocal_task/pages/orders_page.dart';
import 'package:reciprocal_task/pages/product_detail_page.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [

            ListTile(
              title: const Text('Your Orders'),
              onTap: () {
                final name = box.read('Name')??'';
                Get.to(()=>OrdersPage(username: name));
            
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // prefs?.remove('Name');
                Get.offAll(() => LoginScreen());
                Get.back();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CartPage());
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GetBuilder<ProductController>(builder: (controllerProducts) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: controllerProducts.products.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            List<Product> products = controllerProducts.products;
            return InkWell(
              onTap: () {
                cartCount.value = 0;
                Get.to(() => ProductDetailPage(product: products[index]));
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                isThreeLine: true,
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('${products[index].image}'),
                ),
                title: Text('${products[index].title}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${products[index].description?.substring(0, 50)}'),
                    Text('Price: \$${products[index].price}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
