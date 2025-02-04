import 'dart:io';
import 'package:chatbot/splash/splash_screen.dart';
import 'package:chatbot/view/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Debugging: Print current directory
  print("Current Directory: ${Directory.current.path}");

  // Debugging: Check if .env exists
  if (await File('.env').exists()) {
    print("✅ .env file found!");
  } else {
    print("❌ .env file is missing!");
  }

  await dotenv.load(fileName: ".env");
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChatScreen(),
  ));
}