import 'package:chatbot/auth/signup.dart';
import 'package:chatbot/controller/auth_controller.dart';
import 'package:chatbot/view/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String emailError = '';
  String passwordError = '';
  bool isLoading = false;
  bool showPassword = false; // State for password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/mobile.jpg', fit: BoxFit.cover),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Center(child: Image.asset('assets/logo.png', height: 100)),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    buildTextField("Email ID", Icons.email, false, emailController, false),
                    if (emailError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(emailError, style: TextStyle(color: Colors.red)),
                      ),
                    const SizedBox(height: 15),
                    buildTextField("Enter Password", Icons.lock, true, passwordController, true),
                    if (passwordError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(passwordError, style: TextStyle(color: Colors.red)),
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: isLoading ? null : _handleLogin,
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.black)
                            : Text("Log In", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.to(() => SingupScreen()),
                        child: Text("Create an account Sign Up", style: TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Function to handle login
  Future<void> _handleLogin() async {
    setState(() {
      emailError = '';
      passwordError = '';
      isLoading = true; // Show loading indicator
    });

    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty) {
      setState(() {
        emailError = 'Please enter your email';
        isLoading = false;
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Please enter your password';
        isLoading = false;
      });
      return;
    }

    bool isLoggedIn = await authController.login(email, password);

    if (isLoggedIn) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      Get.off(() => ChatScreen());
    } else {
      setState(() {
        emailError = 'Invalid email or password';
        passwordError = 'Invalid email or password';
        isLoading = false; // Hide loading indicator
      });
    }
  }

  /// TextField builder function with password visibility toggle
  Widget buildTextField(String hint, IconData icon, bool isPassword, TextEditingController controller, bool isPasswordField) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField ? !showPassword : false,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.black.withOpacity(0.1),
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
