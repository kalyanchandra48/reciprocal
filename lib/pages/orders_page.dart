

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reciprocal_task/models/product.dart';
import 'package:reciprocal_task/services/firestore_service.dart';

class OrdersPage extends StatelessWidget{
  

  final String username;
  OrdersPage({super.key, required this.username});
    // Pass your orders data here


  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders; 
   return Scaffold(
    body: StreamBuilder<List<Map<String, dynamic>>>(
  stream: firestoreService.getUserOrders(username),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Text('No orders found');
    } else {
      final orders = snapshot.data!;
      return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          var order = orders[index];
          var orderID = order['orderID'];
          var orderData = order['orderData'];
          var products = orderData['products'] as List<dynamic>;

          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: $orderID', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, prodIndex) {
                      var product = products[prodIndex];
                      return ListTile(
                        leading: Image.network(
                          product['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product['title']),
                        subtitle: Text(product['description']),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Quantity: ${product['quantity']}'),
                            Text('Price: \$${product['price']}'),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  },
)

   );
  }
}