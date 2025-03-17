import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthire_ai/main.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/ai.jpg'), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.9,
            child: Container(
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "AI Resume Analyzer",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      "Make your resume strong with AI",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResumeAnalyzenCheck()));
                    },
                    child: Container(
                      height: 70,
                      width: 230,
                      margin: EdgeInsets.only(top: 24),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                spreadRadius: 4)
                          ]),
                      child: Center(
                          child: Text(
                        "Get Started",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
