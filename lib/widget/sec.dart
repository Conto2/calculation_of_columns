import 'package:flutter/material.dart';

class Sec extends StatelessWidget {
  const Sec({super.key, required this.label, this.onTap, required this.num});
  final String label;
  final String num;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(10),
        height: h / 5,
        width: w / 2.5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.black54)
            // boxShadow: const [
            //   BoxShadow(
            //     blurRadius: 4,
            //     spreadRadius: 2,
            //     color: Colors.black12,
            //   )
            // ],
            ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 00),
                // Text(
                //   num,
                //   style: TextStyle(
                //     fontSize: 25,
                //   ),
                // ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  label,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
