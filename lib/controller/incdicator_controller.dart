import 'package:get/get.dart';

class TypingIndicatorController extends GetxController {
  var currentDot = 0.obs;

  @override
  void onInit() {
    super.onInit();
    startTypingAnimation();
  }

  void startTypingAnimation() {
    ever(currentDot, (_) {
      Future.delayed(Duration(milliseconds: 400), () {
        currentDot.value = (currentDot.value + 1) % 3;
      });
    });
    currentDot.value = 0; // Start the animation loop
  }
}
