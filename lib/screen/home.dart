import 'dart:io';

import 'package:calculation_of_columns/screen/colums/num_four.dart';
import 'package:calculation_of_columns/screen/colums/num_one.dart';
import 'package:calculation_of_columns/screen/colums/num_thre.dart';
import 'package:calculation_of_columns/screen/colums/num_two.dart';
import 'package:calculation_of_columns/widget/custom_button.dart';
import 'package:calculation_of_columns/widget/sec.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Columns',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              '1 :  axially loaded column',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Sec(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AnalysisLoadedColumnScreen()));
                    },
                    num: '1',
                    label: 'Analysis '),
                Sec(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DesignLoadedColumnScreen()));
                    },
                    num: '2',
                    label: 'Design '),
              ],
            ),
            SizedBox(height: 30),
            Container(height: 1.9, color: Colors.black45),
            SizedBox(height: 30),
            Text(
              '2 : rectangular columns',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Sec(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AnalysisRectangularColumnsScreen()));
                    },
                    num: '3',
                    label: ' Analysis'),
                Sec(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DesignRectangularColumnsScreen()));
                    },
                    num: '4',
                    label: 'Design'),
              ],
            ),
            InkWell(
              onTap: () {
                exit(0);
              },
              child: Container(
                margin: EdgeInsets.all(20),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54, width: 2),
                ),
                child: Center(
                  child: Text(
                    'Exit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
