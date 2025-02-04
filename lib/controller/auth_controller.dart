import 'package:chatbot/auth/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;

  // Check if the user is already logged in
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    userEmail.value = prefs.getString('userEmail') ?? '';
  }

  // Validate the email format
  bool validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  // Log in the user and save their data
  Future<bool> login(String email, String password) async {
    if (!validateEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar("Invalid Password", "Password cannot be empty.");
      return false;
    }

    // Simulate backend verification
    await Future.delayed(Duration(seconds: 2)); // Simulating delay

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    isLoggedIn.value = true;
    userEmail.value = email;

    Get.snackbar("Login Successful", "Welcome back, $email!");
    return true;
  }

  // Register a new user
  Future<bool> signup(String email, String password) async {
    if (!validateEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar("Invalid Password", "Password cannot be empty.");
      return false;
    }

    // Simulate backend sign up (replace with actual API call)
    await Future.delayed(Duration(seconds: 2)); // Simulating delay

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    isLoggedIn.value = true;
    userEmail.value = email;

    Get.snackbar("Sign Up Successful", "Account created successfully.");
    return true;
  }

  // Log out the user and clear data
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    isLoggedIn.value = false;
    userEmail.value = '';
    Get.snackbar("Logged Out", "You have been logged out successfully.");
    Get.off(LoginScreen());
  }
}
