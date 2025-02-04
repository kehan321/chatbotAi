import 'package:chatbot/controller/auth_controller.dart';
import 'package:chatbot/controller/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';

class ChatScreen extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return MaterialApp(
          themeMode: themeController.themeMode.value,
          theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1C97C1)),
            scaffoldBackgroundColor: Colors.white,
            textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
          ),
          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(backgroundColor: Colors.black87),
            scaffoldBackgroundColor: Colors.black,
            textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                'VIORA',
                style: TextStyle(
                  color: themeController.themeMode.value == ThemeMode.dark
                      ? Colors.white // White text in dark mode
                      : Colors.white, // Black text in light mode
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              backgroundColor:
                  themeController.themeMode.value == ThemeMode.light
                      ? Color(0xFF1C97C1)
                      : Colors.grey,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: themeController.toggleTheme,
                ),
                IconButton(
                  icon: Icon(Icons.logout_outlined),
                  onPressed: () {
                    // Show the confirmation dialog using GetX
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        elevation: 16,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Confirm Logout',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Are you sure you want to log out?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.back(); // Close the dialog
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Perform the logout action
                                      authController.logout();
                                      Get.back(); // Close the dialog
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .red, // Red color for logout button
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(1.0), // Set the height of the bottom border
                child: Container(
                  color: Colors.white, // White border color
                  height: 6.0, // Set the thickness of the border
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      reverse: true,
                      itemCount: chatController.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatController.messages[index];
                        bool isUserMessage = message['sender'] == 'You';

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10.0),
                          child: Align(
                            alignment: isUserMessage
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 18.0),
                              decoration: BoxDecoration(
                                color: isUserMessage
                                    ? Color(0xFF1C97C1)
                                    : themeController.themeMode.value ==
                                            ThemeMode.light
                                        ? Colors.grey[200]
                                        : Colors.grey[800],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: message['message'] == '...' &&
                                      !isUserMessage
                                  ? _buildTypingIndicator() // Show typing indicator
                                  : Text(
                                      message['message']!,
                                      style: TextStyle(
                                        color: isUserMessage
                                            ? Colors.white
                                            : themeController.themeMode.value ==
                                                    ThemeMode.light
                                                ? Colors.black87
                                                : Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Expanded(
                          child: TextField(
                            controller: chatController.controller,
                            style: TextStyle(
                              color: themeController.themeMode.value ==
                                      ThemeMode.dark
                                  ? Colors.white // White text in dark mode
                                  : Colors.black, // Black text in light mode
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your message...',
                              filled: true, // Enable fillColor
                              fillColor: themeController.themeMode.value ==
                                      ThemeMode.dark
                                  ? Colors
                                      .grey[800] // Dark mode background color
                                  : Colors
                                      .grey[200], // Light mode background color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Color(0xFF1C97C1), width: 1),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: chatController.sendMessage,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF1C97C1),
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      Obx(
                        () => GestureDetector(
                          onLongPress: chatController.startListening,
                          onLongPressUp: chatController.stopListening,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: chatController.isListening.value
                                ? Colors.redAccent
                                : Colors.grey,
                            child: Icon(
                              chatController.isListening.value
                                  ? Icons.mic_off
                                  : Icons.mic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'AI ',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        SizedBox(width: 6),
        SizedBox(
          width: 20,
          height: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
