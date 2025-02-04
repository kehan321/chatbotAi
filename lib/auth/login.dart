import 'package:chatbot/auth/signup.dart';
import 'package:chatbot/controller/auth_controller.dart';
import 'package:chatbot/view/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  // Create TextEditingController for the email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/mobile.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Image.asset('assets/logo.png', height: 100),
                  ),
                ),
                Center(
                  child: const Text(
                    "VIORA",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40),
                Center(child: const Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.black))),
                const SizedBox(height: 15),
                buildTextField("Email ID", Icons.email, false, emailController),
                const SizedBox(height: 15),
                buildTextField("Enter Password", Icons.lock, true, passwordController),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;

                      // Validate the input before logging in
                      if (email.isNotEmpty && password.isNotEmpty) {
                        // Log in the user and save their data in SharedPreferences
                        await authController.login(email, password);
                        // Navigate to the chat screen after login
                        Get.to(() => ChatScreen());
                      } else {
                        // Show an error if the email or password is empty
                        Get.snackbar("Error", "Please enter both email and password");
                      }
                    },
                    child: const Text("Log In", style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => SingupScreen());
                    },
                    child: const Text("Create an account", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build the text field for email/password input
  Widget buildTextField(String hint, IconData icon, bool obscure, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.1),
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
