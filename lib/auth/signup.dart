import 'package:chatbot/auth/login.dart';
import 'package:chatbot/controller/auth_controller.dart';
import 'package:chatbot/view/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SingupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/mobile.jpg', fit: BoxFit.cover),
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
                    "AQUA MASTER",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 40),
                Center(child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.black))),
                const SizedBox(height: 15),
                buildTextField("Email ID", Icons.email, false),
                const SizedBox(height: 15),
                buildTextField("Enter Password", Icons.lock, true),
                const SizedBox(height: 15),
                buildTextField("Confirm Password", Icons.lock, true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      // Assuming successful sign up
                      await authController.login('user@example.com', 'password123');
                      Get.to(() => ChatScreen());
                    },
                    child: const Text("Account created", style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: const Text("Already have an account?Login", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hint, IconData icon, bool obscure) {
    return TextField(
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
