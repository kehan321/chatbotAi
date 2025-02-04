import 'package:chatbot/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatbot/controller/auth_controller.dart';

class SingupScreen extends StatefulWidget {
  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Validate Email
  bool validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/mobile.jpg', fit: BoxFit.cover),
          SingleChildScrollView(  // Prevent bottom overflow when keyboard is open
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Center(
                    child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(height: 15),
                  buildTextField("Email ID", Icons.email, false, emailController),
                  if (emailError.isNotEmpty) 
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(emailError, style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 15),
                  buildTextFieldWithIcon("Enter Password", Icons.lock, passwordController, obscurePassword, (val) {
                    setState(() {
                      obscurePassword = val;
                    });
                  }),
                  if (passwordError.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(passwordError, style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 15),
                  buildTextFieldWithIcon("Confirm Password", Icons.lock, confirmPasswordController, obscureConfirmPassword, (val) {
                    setState(() {
                      obscureConfirmPassword = val;
                    });
                  }),
                  if (confirmPasswordError.isNotEmpty) 
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(confirmPasswordError, style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        setState(() {
                          emailError = '';
                          passwordError = '';
                          confirmPasswordError = '';
                        });

                        String email = emailController.text;
                        String password = passwordController.text;
                        String confirmPassword = confirmPasswordController.text;

                        if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                          setState(() {
                            if (email.isEmpty) emailError = 'Please enter an email.';
                            if (password.isEmpty) passwordError = 'Please enter a password.';
                            if (confirmPassword.isEmpty) confirmPasswordError = 'Please confirm your password.';
                          });
                          return;
                        }

                        if (!validateEmail(email)) {
                          setState(() {
                            emailError = 'Please enter a valid email.';
                          });
                          return;
                        }

                        if (password != confirmPassword) {
                          setState(() {
                            passwordError = 'Passwords do not match.';
                          });
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        bool isSignedUp = await authController.signup(email, password);

                        if (isSignedUp) {
                          Get.to(() => LoginScreen());
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Get.snackbar("Signup Failed", "An error occurred. Please try again.");
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.black)
                          : const Text("Sign Up", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget buildTextFieldWithIcon(String hint, IconData icon, TextEditingController controller, bool obscure, Function(bool) onEyePressed) {
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
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: () {
            onEyePressed(!obscure); // Toggle visibility
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
