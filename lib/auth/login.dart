// import 'package:chatbot/auth/signup.dart';
// import 'package:chatbot/controller/auth_controller.dart';
// import 'package:chatbot/view/chatScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final AuthController authController = Get.put(AuthController());

//   // Create TextEditingController for the email and password input
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // Create variables to hold error messages
//   String emailError = '';
//   String passwordError = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             'assets/mobile.jpg',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Center(
//                     child: Image.asset('assets/logo.png', height: 100),
//                   ),
//                 ),
//                 Center(
//                   child: const Text(
//                     "VIORA",
//                     style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Center(child: const Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.black))),
//                 const SizedBox(height: 15),
//                 buildTextField("Email ID", Icons.email, false, emailController),
//                 if (emailError.isNotEmpty) 
//                   Padding(
//                     padding: const EdgeInsets.only(left: 12.0),
//                     child: Text(emailError, style: TextStyle(color: Colors.red)),
//                   ),
//                 const SizedBox(height: 15),
//                 buildTextField("Enter Password", Icons.lock, true, passwordController),
//                 if (passwordError.isNotEmpty) 
//                   Padding(
//                     padding: const EdgeInsets.only(left: 12.0),
//                     child: Text(passwordError, style: TextStyle(color: Colors.red)),
//                   ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                     onPressed: () async {
//                       String email = emailController.text;
//                       String password = passwordController.text;

//                       // Reset error messages
//                       setState(() {
//                         emailError = '';
//                         passwordError = '';
//                       });

//                       // Validate the input before logging in
//                       if (email.isNotEmpty && password.isNotEmpty) {
//                         // Try logging in the user
//                         bool isLoggedIn = await authController.login(email, password);

//                         // Check if the login was successful
//                         if (isLoggedIn) {
//                           // Save user data in SharedPreferences
//                           SharedPreferences prefs = await SharedPreferences.getInstance();
//                           prefs.setString('email', email);

//                           // Navigate to the chat screen after login
//                           Get.to(() => ChatScreen());
//                         } else {
//                           // Show error messages if login fails
//                           setState(() {
//                             emailError = 'Invalid email or password';
//                             passwordError = 'Invalid email or password';
//                           });
//                         }
//                       } else {
//                         // Show error messages if fields are empty
//                         setState(() {
//                           if (email.isEmpty) {
//                             emailError = 'Please enter your email';
//                           }
//                           if (password.isEmpty) {
//                             passwordError = 'Please enter your password';
//                           }
//                         });
//                       }
//                     },
//                     child: const Text("Log In", style: TextStyle(fontSize: 18)),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(() => SingupScreen());
//                     },
//                     child: const Text("Create an account", style: TextStyle(fontSize: 16, color: Colors.black)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Build the text field for email/password input
//   Widget buildTextField(String hint, IconData icon, bool obscure, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       obscureText: obscure,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.black),
//         filled: true,
//         fillColor: Colors.black.withOpacity(0.1),
//         prefixIcon: Icon(icon, color: Colors.black),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }
// }


import 'package:chatbot/auth/signup.dart';
import 'package:chatbot/controller/auth_controller.dart';
import 'package:chatbot/view/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                if (emailError.isNotEmpty) 
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(emailError, style: TextStyle(color: Colors.red)),
                  ),
                const SizedBox(height: 15),
                buildTextField("Enter Password", Icons.lock, true, passwordController),
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
                        backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;

                      setState(() {
                        emailError = '';
                        passwordError = '';
                      });

                      if (email.isNotEmpty && password.isNotEmpty) {
                        bool isLoggedIn = await authController.login(email, password);

                        if (isLoggedIn) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('email', email);

                          Get.to(() => ChatScreen());
                        } else {
                          setState(() {
                            emailError = 'Invalid email or password';
                            passwordError = 'Invalid email or password';
                          });
                        }
                      } else {
                        setState(() {
                          if (email.isEmpty) {
                            emailError = 'Please enter your email';
                          }
                          if (password.isEmpty) {
                            passwordError = 'Please enter your password';
                          }
                        });
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
