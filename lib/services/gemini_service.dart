import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel model;

  GeminiService(String apiKey)
      : model = GenerativeModel(
          model: 'gemini-2.0-flash', //'gemini-1.5-pro
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 0.7,
            maxOutputTokens: 500,
            responseMimeType: 'text/plain',
          ),
        );

  Future<String> analyzeResume(String resumeText) async {
    final chat = model.startChat(history: []);
    final content = Content.text(
        "Analyze this resume and provide improvements:\n$resumeText");
    final response = await chat.sendMessage(content);
    return response.text ?? "Error analyzing resume.";
  }

  Future<String> getChatbotResponse(String userQuery) async {
    final chat = model.startChat(history: []);
    final content = Content.text(userQuery);
    final response = await chat.sendMessage(content);
    return response.text ?? "Error getting chatbot response.";
  }

  Future<String> checkResume(String resumeText) async {
    final chat = model.startChat(history: []);
    final content = Content.text(
        "You are an HR in an I.T company. Your job is to review the resume below and rate it from 0 to 100 based on work experience, skills, and qualifications. "
            "Respond with only the number, nothing else:\n $resumeText");

    try {
      final response = await chat.sendMessage(content);
      String responseText = response.text?.trim() ?? "0";

      print("Gemini Response: $responseText"); // Debugging log

      // Extract only numeric score from response
      RegExp regex = RegExp(r'\b(100|[1-9]?[0-9])\b'); // Matches numbers from 0-100
      Match? match = regex.firstMatch(responseText);

      if (match != null) {
        return match.group(0)!; // Extracted number
      } else {
        return "0"; // Default if no valid number is found
      }
    } catch (e) {
      print("Error in checkResume: $e");
      return "0"; // Return 0 in case of error
    }
  }


}

