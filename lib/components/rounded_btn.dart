import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgcolor;
  final TextStyle? textStyle;
  final VoidCallback? callback;

  RoundedButton(
      {required this.btnName,
        this.icon,
        this.bgcolor = Colors.blue,
        this.textStyle,
        this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback!();
      },
      child: icon != null
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnName,
            style: textStyle,
          ),
          SizedBox(
            width: 105,
          ),
          icon!,

        ],
      )
          : Text(
        btnName,
        style: textStyle,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(25),
          //   topRight: Radius.circular(25),),
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}
