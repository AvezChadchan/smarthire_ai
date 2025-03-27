import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthire_ai/chatbot/chatbot.dart';
import 'package:smarthire_ai/components/rounded_btn.dart';

class ChatBotHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Container(
          margin: EdgeInsets.only(top: 17),
          child: Text(
            "Chat with our AI",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 32),
          ),
        )),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF0D47A1),
              ],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35),
                height: 200,
                width: 300,
                // color: Colors.red,
                child: Center(
                    child: Text(
                  "How can we \nhelp you?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 32),
                )),
              ),
              Text(
                "We are available 24/7 to help\n clarify any confusion you have \nregarding your resume",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.white),
              ),
              Container(
                  margin: EdgeInsets.only(top: 45, bottom: 20),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                  ),
                  height: 95,
                  child: Icon(
                    Icons.email_outlined,
                    size: 90,
                    color: Color(0xFF0D47A1),
                  )),
              Text(
                "Send us an email:\n if you have any query",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                "ajinkyaop17@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              Container(
                  margin: EdgeInsets.only(top: 60),
                  width: 350,
                  child: RoundedButton(
                    callback: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => chatBot()));
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 35,
                    ),
                    btnName: "Chat with Bot",
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    bgcolor:Colors.white60,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
