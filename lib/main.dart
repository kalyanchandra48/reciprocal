import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reciprocal_task/controllers/product_controller.dart';
import 'package:reciprocal_task/firebase_options.dart';
import 'package:reciprocal_task/pages/login_screen.dart';
import 'package:reciprocal_task/pages/products_page.dart';

final box = GetStorage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await GetStorage.init();

  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 String name = box.read('Name') ?? '';
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      
     name.isNotEmpty ? const ProductsListPage() :
       LoginScreen(),
    );
  }
}
