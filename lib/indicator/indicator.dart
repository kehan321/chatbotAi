import 'package:chatbot/controller/incdicator_controller.dart';
import 'package:chatbot/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypingIndicator extends StatelessWidget {
  final TypingIndicatorController controller =
      Get.put(TypingIndicatorController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('VIORA ',
            style: TextStyle(
                fontSize: 16,
                color: themeController.themeMode.value == ThemeMode.light
                    ? Colors.black87
                    : Colors.white)),
        SizedBox(width: 6),
        Obx(() => Row(
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: themeController.themeMode.value == ThemeMode.light
                        ? controller.currentDot.value == index
                            ? Colors.black
                            : Colors.black38
                        : controller.currentDot.value == index
                            ? Colors.grey
                            : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            )),
      ],
    );
  }
}
