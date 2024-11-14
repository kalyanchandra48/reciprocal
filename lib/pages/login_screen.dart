import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reciprocal_task/auth/firebase_authentication.dart';
import 'package:reciprocal_task/main.dart';
import 'package:reciprocal_task/pages/products_page.dart';
import 'package:reciprocal_task/pages/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
          ),
          // Add a button to submit the form
          Container(
            margin: const EdgeInsets.only(top: 19.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _authService
                    .signInWithEmailAndPassword(
                        _emailController.text, _passwordController.text)
                    .then((user) {
                  if (user != null) {
                   box.write('Name', user.displayName ?? user.email.toString());
                    
                    Get.to(() => const ProductsListPage());
                  } else {
                    // Show an error message
                  }
                });
              },
              child: const Text('Login'),
            ),
          ),

          // Add a button to navigate to the registration screen
          TextButton(
            onPressed: () {
              Get.to(() => SignupScreen());
            },
            child: const Text('Doesn\'t have an account? Register'),
          ),
        ],
      ),
    ));
  }
}
