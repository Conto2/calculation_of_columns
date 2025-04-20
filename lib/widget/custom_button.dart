import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? buttonheigh;
  final double? buttonwidth;
  final Color? buttoncolor;
  final Color? textcolor;
  final void Function()? onPressed;
  const CustomButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.buttoncolor,
      this.textcolor,
      this.buttonheigh,
      this.buttonwidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 2,
            color: Colors.black12,
          )
        ],
        color: buttoncolor,
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(
        //   color: Colors.black54,
        //   width: 1.2,
        // ),
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: MaterialButton(
        minWidth: buttonwidth ?? 340,
        height: buttonheigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        // color: ,
        textColor: textcolor,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,

            //   fontFamily:ThemeData == themeEnglish? "Reem" : "Abril" ,
          ),
        ),
      ),
    );
  }
}
