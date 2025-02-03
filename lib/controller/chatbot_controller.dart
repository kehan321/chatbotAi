import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = <Map<String, String>>[].obs;
  final RxBool isListening = false.obs;
  final RxBool isTyping = false.obs; // New flag for loading animation
  late stt.SpeechToText speechToText;
  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  @override
  void onInit() {
    super.onInit();
    speechToText = stt.SpeechToText();
  }

  Future<void> sendMessage() async {
    String userMessage = controller.text.trim();
    if (userMessage.isEmpty) return;

    messages.insert(0, {'sender': 'You', 'message': userMessage});
    controller.clear();
    update();

    await _showTypingIndicator();
    String aiResponse = await getResponseFromAI(userMessage);
    _replaceTypingIndicator(aiResponse);
  }

  Future<void> sendVoiceMessage(String voiceText) async {
    messages.insert(0, {'sender': 'You', 'message': voiceText});
    update();

    await _showTypingIndicator();
    String aiResponse = await getResponseFromAI(voiceText);
    _replaceTypingIndicator(aiResponse);
  }

  Future<void> _showTypingIndicator() async {
    isTyping.value = true;
    messages.insert(0, {'sender': 'AI', 'message': '...'});
    update();
  }

  void _replaceTypingIndicator(String aiResponse) {
    isTyping.value = false;
    messages.removeWhere((msg) => msg['message'] == '...');
    messages.insert(0, {'sender': 'AI', 'message': aiResponse});
    update();
  }

  Future<String> getResponseFromAI(String prompt, {int retries = 3}) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else if (response.statusCode == 429 && retries > 0) {
        await Future.delayed(Duration(seconds: 2));
        return await getResponseFromAI(prompt, retries: retries - 1);
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Request failed: $e';
    }
  }

  void startListening() async {
    bool available = await speechToText.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      isListening.value = true;
      speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            sendVoiceMessage(result.recognizedWords);
          }
        },
      );
    }
  }

  void stopListening() {
    isListening.value = false;
    speechToText.stop();
  }
}
