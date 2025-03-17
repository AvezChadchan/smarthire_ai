import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:smarthire_ai/services/gemini_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GeminiService geminiService =
      GeminiService("AIzaSyBKmzokMoJXFlJF9YWbbCHhaOoo6FLB4J8");
  String resumeContent = "No resume uploaded.";
  String aiSuggestions = "AI suggestions will appear here.";

  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      File file = await File(result.files.single.path!);
      String fileContent = await file.readAsString();
      setState(() {
        resumeContent = fileContent;
      });
      String analysis = await geminiService.analyzeResume(fileContent);
      setState(() {
        aiSuggestions = analysis;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Container(
              margin: EdgeInsets.only(top: 17),
              child: Text(
                        'AI Resume Analyzer',
                        style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
            )),
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
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text("Resume Content:\n$resumeContent",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  pickResume();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 70,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color(0xFF0D47A1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14)),
                      border: Border.all(color: Colors.white, width:1.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue,
                            blurRadius: 18,
                            spreadRadius: 5),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Upload Resume",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.file_copy_outlined,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Text(
                      "AI Suggestions:\n$aiSuggestions",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
