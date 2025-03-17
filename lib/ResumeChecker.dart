import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smarthire_ai/services/gemini_service.dart';

class ResumeChecker extends StatefulWidget {
  @override
  State<ResumeChecker> createState() => _ResumeCheckerState();
}

class _ResumeCheckerState extends State<ResumeChecker> {
  final GeminiService geminiService =
      GeminiService("");
  String resumeContent = "No resume uploaded.";
  String score = "Your Score";
  int numericScore = 0;
  bool isScoreGood = false;
  String Message = "";
  Future<void> pickresumetoCheck() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      File file = await File(result.files.single.path!);
      String fileCotent = await file.readAsString();
      setState(() {
        resumeContent = fileCotent;
      });
      String resumeScore = await geminiService.checkResume(fileCotent);
      setState(() {
        score = resumeScore;
        try {
          numericScore = int.parse(score);
        } catch (e) {
          numericScore = 0; // Default value
          print("Error parsing score: $e");
        }
        isScoreGood = numericScore > 60;
        Message = isScoreGood
            ? "You are Eligible to apply for Job"
            : "You are not Eligible to apply for Job.";
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
            'AI Resume Checker',
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
                    child: Text(
                      "Resume Content: \n$resumeContent",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  pickresumetoCheck();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 75,
                  width: 275,
                  decoration: BoxDecoration(
                      color: Color(0xFF0D47A1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14)),
                      border: Border.all(color: Colors.white, width: 1.5),
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
                        "Upload Resume to Check",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.file_upload_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              numericScore > 0
                  ? Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: isScoreGood ? Colors.blue : Colors.red,
                              borderRadius: BorderRadius.circular(13),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Text(
                            "Your Score: \n$numericScore\n$Message",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
