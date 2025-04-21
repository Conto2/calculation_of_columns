// import 'package:calculation_of_columns/screen/num_one.dart';

import 'package:calculation_of_columns/screen/splsh.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تحليل وتصميم الاعمده بمساعده الحاسوب',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      //ColumnDesignPage(),
    );
  }
}
