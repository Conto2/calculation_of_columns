import 'dart:io';
import 'dart:math';

import 'package:calculation_of_columns/widget/custom_button.dart';
import 'package:flutter/material.dart';

class DesignRectangularColumnsScreen extends StatefulWidget {
  const DesignRectangularColumnsScreen({super.key});

  @override
  _ColumnDesignPageState createState() => _ColumnDesignPageState();
}

class _ColumnDesignPageState extends State<DesignRectangularColumnsScreen> {
  // Controllers لحقول النص
  final TextEditingController fcController = TextEditingController(); // f'c
  final TextEditingController fyController = TextEditingController(); // f_y
  final TextEditingController asController = TextEditingController(); // A_s
  final TextEditingController puController = TextEditingController(); // pu
  final TextEditingController muController = TextEditingController(); // mu
  final TextEditingController fController = TextEditingController(); // f (G)
  final TextEditingController beta1Controller =
      TextEditingController(); // beta1
  final TextEditingController RController = TextEditingController(); // R
  final TextEditingController NController = TextEditingController(); // N
  final TextEditingController roiController = TextEditingController(); //roi
  final TextEditingController bController = TextEditingController(); // b
  // final TextEditingController hController = TextEditingController(); // h
  final TextEditingController dpController = TextEditingController(); // dp
  final TextEditingController eController = TextEditingController(); // E
  final TextEditingController AcController = TextEditingController(); // Ac
  final TextEditingController AbController = TextEditingController(); // Ab
  int shapeValue = 1;
  // متغير لعرض النتيجة
  String resultText = '';
  double d2 = 60;
  double ES = 200000; // MPa

  ///////////
  double d = 0.0;
  double d3 = 0.0;
  double ab = 0.0;
  double phi = 0.65;
  double ff = 0.0;
  double Pnb = 0.0;
  double eb = 0.0;
  double Pn = 0.0;
  double m = 0.0;
  double e2 = 0.0;
  double roi2 = 0.0;
  double As = 0.0;
  double N = 0.0;
  double S = 0.0;
  double Ag = 0.0;
  double h = 0.0;
  double b = 0.0;
  double f = 0.0;
  double e = 0.0;
  double Ab = 0.0;
  double pu = 0.0;
  double R = 0.0;
  double dp = 0.0;
  double com = 0.0;
  String lab = '';
  // int h23 = 732;

  // الدالة التي تطبق الخوارزمية

  void calculate() {
    Pn = 0.0;
    try {
      Pn = 0.0;
      //   print('=================clean==============$h');
      // 1) جلب القيم من حقول النص
      double fc = double.tryParse(fcController.text) ?? 0.0; // f'c
      double fy = double.tryParse(fyController.text) ?? 0.0; // f_y
      //  double As = double.tryParse(asController.text) ?? 0.0; // A_s
      pu = double.tryParse(puController.text) ?? 0.0; // PU
      double mu = double.tryParse(muController.text) ?? 0.0; // mu
      //  double f = double.tryParse(fController.text) ?? 0.0; // f (G)
      double beta1 = double.tryParse(beta1Controller.text) ?? 0.0; // معامل أمان
      R = double.tryParse(RController.text) ?? 0.0; // R
      double roi1 = double.tryParse(roiController.text) ?? 0.0; // roi
      // double b = double.tryParse(bController.text) ?? 0.0; // b
      // double h = double.tryParse(hController.text) ?? 0.0; // h
      double db = double.tryParse(dpController.text) ?? 0.0; // db
      // double e = double.tryParse(eController.text) ?? 0.0; // معامل المرونة
      // double Ac = double.tryParse(AcController.text) ?? 0.0; // Ac
      //  double Ab = double.tryParse(AbController.text) ?? 0.0; // Ab
//////////////////////

      double transformNumber(double n) {
        // استخراج الجزء الصحيح من الرقم باستخدام truncate() (يتجاهل الكسور)
        int integerPart = n.truncate();

        // إذا كان الرقم الفردي، نضيف 1 ليصبح زوجيًا
        if (integerPart % 2 != 0) {
          integerPart += 1;
        }

        // إرجاع النتيجة على شكل double مع جزء عشري 0
        return integerPart.toDouble();
      }

////////////
      //   print('====================$e');
      e = (mu * pow(10, 3)) / pu;

      ///
      if (e > 200.0) {
        f = 0.2;
      } else if (e < 200.0) {
        f = 0.4;
      }

      ///
      ///

      ///
      Ag = (pu * pow(10, 3)) / (f * fc);
      //////////////////////
      int roundNumberS(S) {
        // استخراج خانة العشرات
        int tens = (S ~/ 10) % 10;
        // استخراج خانة المئات
        int hundreds = S ~/ 100;

        // إذا كانت خانة العشرات أكبر من   5،
        // يتم تقريب الرقم إلى المئة التالية
        if (tens >= 5) {
          return hundreds * 100 + 50;
        } else {
          // إذا كانت خانة العشرات أقل من 5،
          // فإن الرقم يُقرب إلى قيمة تنتهي بـ 50
          return (hundreds) * 100;
        }
      }

      //////////////////////////////
      int roundNumber(h) {
        // استخراج خانة العشرات
        int tens = (h ~/ 10) % 10;
        // استخراج خانة المئات
        int hundreds = h ~/ 100;

        // إذا كانت خانة العشرات أكبر من   5،
        // يتم تقريب الرقم إلى المئة التالية
        if (tens >= 5) {
          return (hundreds + 1) * 100;
        } else {
          // إذا كانت خانة العشرات أقل من 5،
          // فإن الرقم يُقرب إلى قيمة تنتهي بـ 50
          return hundreds * 100 + 50;
        }
      }

      // double  k = ;
      // print('============ffffft1 =========== $h');
      h = roundNumber(h).toDouble();

//////////
      if (shapeValue == 0) {
        b = double.tryParse(bController.text) ?? 0.0;
        // مستطيل
        print('مستطيل');
        h = Ag / b;
      } else {
        // مر
        // بع

        print('مربع');
        h = pow(Ag, 1 / 2).toDouble();
        h = roundNumber(h).toDouble();
        b = h;
      }
//////
      d = h - d2;

      ///

      ///

      ///
      d3 = (h / 2) - d2;

      ///
      double cb = (600 / (600 + ff)) * d;
      ab = beta1 * cb;

      ///
      double epsS = 0.003 * (cb - d2) / cb;
      double fs = ES * epsS;
      double epsy2 = fy / ES;
      if (epsS < epsy2) {
        ff = fs;
      } else {
        ff = fy;
      }
      /////////
      // Step 4
      double Cc = 0.85 * fc * ab * b;
      double T = As * ff;
      double Cs = As * (ff - 0.85 * fc);
      ///////////////////
      Pnb = Cc + Cs - T;
      ///////////////////
      eb = ((Cc * (d - (ab / 2)) + Cs * (d - d2)) / Pnb) - ((h / 2) - d2);

///////////////
      Ab = (pi * pow(db, 2)) / 4;
      double Ast = roi1 * b * h;
      N = Ast / Ab;
      ////////////////

      N = transformNumber(N);

      //////////////////
      if (e > eb) {
        // Tension control
        lab = 'Yes Tension control ';
        com = 1;
        print('1');
        ///////////
        m = fy / (0.85 * fc);
        e2 = e + ((d - d2) / 2);
        roi2 = (As / (b * d));
        //  print(object)
        ///////////////
        Pn = 0.85 *
            fc *
            b *
            d *
            (-roi2 +
                1 -
                (e2 / d) +
                pow(
                    pow(1 - (e2 / d), 2) +
                        2 * roi2 * ((m - 1) * (1 - (d2 / d)) + (e2 / d)),
                    1 / 2));
/////////////////
        if (1 < (phi * Pn) / pu) {
          Ast = roi2 * Ab;
        } else if ((pid * Pn) / pu <= 1.1) {
        //  print('Revise Cross Section and / or roi');
          SnackBar(
            content: Text('Revise Cross Section and / or roi'),
            duration: Duration(seconds: 2),
          );
        }
      } else {
        // Compression controls
        com = 2;
        lab = 'Yes Compression controls';
        //////////////////////
        // As = (roi * Ac) / 2;
        ///////////////////////
        Pn = (b * h * fc / ((3 * h * e / (d * d)) + 1.18)) +
            (As * fy / ((e / (d - d2)) + 0.5));
        //////////////////////////
        if (1 < (phi * Pn) / pu) {
          Ast = roi2 * Ab;
        } else if ((pid * Pn) / pu <= 1.1) {
        //  print('Revise Cross Section and / or roi');
            SnackBar(
            content: Text('Revise Cross Section and / or roi'),
            duration: Duration(seconds: 2),
          );
        }
      }
      ///////////
      // N = (Ast / Ab);
      ///////////////
      double re1 = min(b, h);
      double re2 = 16 * db;
      double re3 = R * 48;
      S = min(re1, min(re2, re3));
      Ab = (pi * pow(db, 2)) / 4;
      As = (N / 2) * Ab;
      S = roundNumberS(S).toDouble();
      // print(N);

      print('===========reee========$S');
      /////////////////////
      String output = """
      ============================
      نتائج الحساب (مثال):
      ----------------------------
    //  Pn (Nominal Capacity): ${Pn.toStringAsFixed(2)} 
      N :  ${N.toStringAsFixed(2)} 
      S :  ${S.toStringAsFixed(2)} 
        db :  ${db.toStringAsFixed(2)} 
      h :     ${h.toStringAsFixed(2)}
      b :        ${b.toStringAsFixed(2)} 
      ============================
      """;
      Pn = Pn / 1000;
      // showDetails();
      setState(() {
        resultText = output;
      });
    } catch (e) {
      setState(() {
        resultText = 'خطأ في الإدخال: الرجاء التحقق من صحة الأرقام! $e';
        
      });
    }
  }

  void _clear() {
    setState(() {
      fyController.text = '';
      fcController.text = '';
      puController.text = '';
      muController.text = '';
      beta1Controller.text = '';
      RController.text = '';
      dpController.text = '';
      roiController.text = '';
      bController.text = '';

      bController.text = '';
      b = 0.0;
      h = 0.0;

      R = 0.0;
      N = 0.0;

      dp = 0.0;
      S = 0.0;
      Pn = 0.0;
      lab = '';
    });
    // asController.text = ' 0.0';
  }

  @override
  Widget build(BuildContext context) {
    double widt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Rectangular Columns'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Column Shape',
              style: TextStyle(fontSize: 25),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('Square', style: TextStyle(fontSize: 20)),
                    value: 1,
                    groupValue: shapeValue,
                    onChanged: (val) {
                      setState(() {
                        shapeValue = val ?? 1;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    title: const Text('Rectangular',
                        style: TextStyle(fontSize: 20)),
                    value: 0,
                    groupValue: shapeValue,
                    onChanged: (val) {
                      setState(() {
                        shapeValue = val ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            // حقول الإدخال
            SizedBox(height: 30),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTextField(fcController, 'fc : Mpa', widt / 2.5),
                buildTextField(fyController, 'fy : Mpa', widt / 2.5),
              ],
            ),
            SizedBox(height: 10),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTextField(puController, 'pu : kn', widt / 2.5),
                buildTextField(muController, 'mu : kn.m', widt / 2.5),
              ],
            ),
            SizedBox(height: 10),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTextField(beta1Controller, 'B 1 : %', widt / 2.5),
                buildTextField(RController, 'R : mm', widt / 2.5),
              ],
            ),
            SizedBox(height: 10),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTextField(dpController, 'db : mm', widt / 2.5),
                buildTextField(roiController, 'p', widt / 2.5),
              ],
            ),
            SizedBox(height: 30),

            //       buildTextField(AbController, 'Ab : mm'),

            if (shapeValue == 0) ...[
              buildTextField(bController, 'b : mm', widt),
            ],
            // إذا كان الشكل دائري نظهر إدخال D
            if (shapeValue == 1) ...[],
            const SizedBox(height: 20),

            // زر الحساب
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: calculate,
                  text: 'Calculate',
                  buttonheigh: 50,
                  buttonwidth: widt / 4,
                  buttoncolor: Colors.white,
                  textcolor: Colors.black54,
                ),
                CustomButton(
                  onPressed: _clear,
                  text: 'Clear',
                  buttonheigh: 50,
                  buttonwidth: widt / 4,
                  buttoncolor: Colors.white,
                  textcolor: Colors.black54,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Back',
                  buttonheigh: 50,
                  buttonwidth: widt / 4,
                  buttoncolor: Colors.white,
                  textcolor: Colors.black54,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // عرض النتيجة
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black54, width: 2),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('h = $h : mm', style: TextStyle(fontSize: 20)),
                      Text('b = $b : mm', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('R = $R : mm', style: TextStyle(fontSize: 20)),
                      Text('N = $N', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('S = $S : mm', style: TextStyle(fontSize: 20)),
                      Text('db = $dp : mm', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Text(lab, style: TextStyle(fontSize: 18)),
                          Text('Pn = $Pn', style: TextStyle(fontSize: 18)),
                        ],
                      )),
                    ],
                  )
                ],
              ),
            ),

            Text(
              'the section is save ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'the section is Eceonomic',
              style: TextStyle(fontSize: 18),
            ),
            //Text('R = $R'),

            // Text(' s = $s'),
            // Text(
            //   resultText,
            //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }

  // ودالة مساعدة لبناء TextField
  Widget buildTextField(
      TextEditingController controller, String label, double widt) {
    //  double heigh = MediaQuery.of(context).size.height;

    return Container(
      width: widt,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 20),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
