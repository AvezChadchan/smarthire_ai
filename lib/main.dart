import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smarthire_ai/HomeScreen.dart';
import 'package:smarthire_ai/ResumeChecker.dart';
import 'package:smarthire_ai/chatbot/chatbothome.dart';
import 'package:smarthire_ai/components/StartScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(AIResumeApp());
}

class AIResumeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Resume Analyzerhi & Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(),
    );
  }
}

class ResumeAnalyzenCheck extends StatefulWidget {
  @override
  _ResumeAnalyzenCheckState createState() => _ResumeAnalyzenCheckState();
}

class _ResumeAnalyzenCheckState extends State<ResumeAnalyzenCheck> {
  int selectedIndex = 0;

  final List<Widget> screens = [HomeScreen(), ChatBotHome(), ResumeChecker()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0D47A1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: NavigationBar(
              elevation: 0,
              height: 68,
              backgroundColor: Colors.black,
              indicatorColor: Colors.blueAccent.withOpacity(0.2),
              surfaceTintColor: Colors.transparent,
              onDestinationSelected: (index) {
                if (index < screens.length) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              selectedIndex: selectedIndex,
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Iconsax.home,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: "Home",
                ),
                NavigationDestination(
                    icon: Icon(
                      Icons.chat_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: "ChatBot"),
                NavigationDestination(
                    icon: Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: "Resume Checker"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
