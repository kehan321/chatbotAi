
import 'dart:ui';
import 'package:chatbot/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  bool _hasNavigated = false; // Flag to track navigation

  @override
  void initState() {
    super.initState();

    // Animation controller for the logo pop-up animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Define the scale animation for the logo
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation and repeat it continuously
    _controller.repeat(reverse: true);

    // Navigate to the next screen after a delay (to ensure splash is shown for a while)
    Future.delayed(Duration(seconds: 5), () {
      if (!_hasNavigated) {
        _hasNavigated = true; // Mark navigation as done
        Get.to(LoginScreen()); // Replace with your next screen's route
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/mobile.jpg',
            fit: BoxFit.cover,
          ),
          // Centered Logo with Animation and Glass Effect
          Center(
            child: FadeTransition(
              opacity: _logoAnimation,
              child: ScaleTransition(
                scale: _logoAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Frosted glass effect
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Text below the logo
          Positioned(
            top: 210, // Adjusted to position text after the logo
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'AI CHATBOT',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}