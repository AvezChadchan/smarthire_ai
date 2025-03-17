import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smarthire_ai/services/gemini_service.dart';

class chatBot extends StatefulWidget {
  @override
  chatBotScreen createState() => chatBotScreen();
}

class chatBotScreen extends State<chatBot> {
  late final String apiKey;
  late final GeminiService geminiService;

  @override
  void initState() {
    super.initState();
    apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    geminiService = GeminiService(apiKey);
  }
  List<Map<String, String>> chatMessages = [];
  final TextEditingController chatController = TextEditingController();

  void sendChatMessage() async {
    if (chatController.text.isNotEmpty) {
      String userMessage = chatController.text.toLowerCase().trim();

      setState(() {
        chatMessages.add({"sender": "user", "text": userMessage});
        chatMessages.add({"sender": "ai", "text": "Typing... ⏳"});
      });

      String chat_History = chatMessages
          .map((msg) => "${msg['sender']}: ${msg['text']}")
          .join("\n");

      List<String> related_Keywords = [
        "hi",
        "hello",
        "resume",
        "cv",
        "cover letter",
        "job application",
        "career",
        "interview",
        "linkedin profile",
        "work experience",
        "skills",
        "professional summary"
      ];
      bool isResumeRelated = related_Keywords.any((keyword) =>
          chat_History.contains(keyword) || userMessage.contains(keyword));

      String response;
      if (isResumeRelated) {
        response = await geminiService
            .getChatbotResponse("$chat_History\nUser: $userMessage\nAI:");
      } else {
        response =
            "I only answer questions about resumes. Please ask me about resumes.";
      }

      setState(() {
        chatMessages.removeLast(); // Remove "Typing..."
        chatMessages.add({"sender": "ai", "text": response});
      });

      chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(top: 17, left: 10),
          child: IconButton(
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(top: 17, left: 70),
          child: Text(
            "ChatBot",
            style:  TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF0D47A1),
          Color(0xFF1976D2),
          Color(0xFF0D47A1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  bool isUser = chatMessages[index]["sender"] == "user";
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? Color(0xFF1E88E5) : Color(0xFFBBDEFB),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text(
                          chatMessages[index]["text"] ?? "",
                          style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0, left: 9),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: chatController,
                      decoration: InputDecoration(
                        hintText: "Ask AI for resume tips...",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Color(0xFF42A5F5),
                      size: 40,
                    ),
                    onPressed: sendChatMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
