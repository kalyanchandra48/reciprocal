import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> addProducts(
      String username, List<Map<String, dynamic>> products) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(username);

     await userRef.collection('orders').add({
    'products': products,
    'orderDate': FieldValue.serverTimestamp(),
  });
  }


  Stream<List<Map<String, dynamic>>> getUserOrders(String username) {
  final userRef = FirebaseFirestore.instance.collection('users').doc(username);

  return userRef.collection('orders').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => {
      'orderID': doc.id,
      'orderData': doc.data(),
    }).toList();
  });
}

}
