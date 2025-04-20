import 'dart:math';

import 'package:calculation_of_columns/widget/custom_button.dart';
import 'package:flutter/material.dart';

enum ColumnType { tied, spiral }

class AnalysisLoadedColumnScreen extends StatefulWidget {
  const AnalysisLoadedColumnScreen({super.key});

  @override
  _ColumnCalculatorScreenState createState() => _ColumnCalculatorScreenState();
}

class _ColumnCalculatorScreenState extends State<AnalysisLoadedColumnScreen> {
  final TextEditingController fCController = TextEditingController(); // f'_c
  final TextEditingController fYController = TextEditingController(); // f_y
  final TextEditingController bController = TextEditingController(); // b
  final TextEditingController hController = TextEditingController(); // h
  final TextEditingController dController = TextEditingController(); // D
  final TextEditingController asController = TextEditingController(); // A_s

  ColumnType selectedColumnType = ColumnType.tied;

  double? pNResult;
  double? aGResult;

  @override
  Widget build(BuildContext context) {
    double widt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Loaded Column'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // اختيار نوع العمود (Tied/Spiral)
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<ColumnType>(
                    title: const Text("Tied Column"),
                    value: ColumnType.tied,
                    groupValue: selectedColumnType,
                    onChanged: (val) {
                      setState(() {
                        selectedColumnType = val!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<ColumnType>(
                    title: const Text("Spiral Column"),
                    value: ColumnType.spiral,
                    groupValue: selectedColumnType,
                    onChanged: (val) {
                      setState(() {
                        selectedColumnType = val!;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTextField(fCController, 'fc : Mpa', widt / 2.5),
                buildTextField(fYController, 'fy : Mpa', widt / 2.5),
              ],
            ),
            SizedBox(height: 20),

            // إدخال b, h إذا كان العمود Tied
            if (selectedColumnType == ColumnType.tied) ...[
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTextField(bController, 'b : mm', widt / 2.5),
                  buildTextField(hController, 'h : mm', widt / 2.5),
                ],
              ),
              SizedBox(height: 30),
            ],

            // إدخال D إذا كان العمود Spiral
            if (selectedColumnType == ColumnType.spiral) ...[
              SizedBox(height: 20),
              buildTextField(dController, 'D mm', widt),
            ],

            buildTextField(asController, 'A_s : mm2', widt),
            const SizedBox(height: 30),

            // زر الحساب
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: _calculate,
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

            // عرض النتائج
            if (pNResult != null) ...[
              const SizedBox(height: 50),
              Text(
                "A_g = ${aGResult?.toStringAsFixed(2)} : mm2",
                style: const TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "P_n = ${pNResult?.toStringAsFixed(2)} : kn",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _clear() {
    setState(() {
      fCController.text = '';
      fYController.text = '';
      bController.text = '';
      hController.text = '';
      dController.text = '';
      asController.text = '';
      pNResult = 0.0;
      aGResult = 0.0;
    });
    // asController.text = ' 0.0';
  }

  void _calculate() {
    // تحويل المدخلات إلى أرقام
    final fC = double.tryParse(fCController.text) ?? 0.0;
    final fY = double.tryParse(fYController.text) ?? 0.0;
    final b = double.tryParse(bController.text) ?? 0.0;
    final h = double.tryParse(hController.text) ?? 0.0;
    final d = double.tryParse(dController.text) ?? 0.0;
    final As = double.tryParse(asController.text) ?? 0.0;

    double aG = 0.0;
    if (selectedColumnType == ColumnType.tied) {
      aG = b * h;
    } else {
      aG = (pi * pow(d, 2)) / 4;
      // aG = (3.14159 * d * d) / 4;
    }

    double pN = 0.0;
    double pN2 = 0.0;

    if (selectedColumnType == ColumnType.tied) {
      // حسب الخوارزمية للعمود المربوط
      pN = 0.85 * fC * (aG - As) + fY * As;
      pN2 = pN * 0.8 * pow(10, -3);
    } else {
      // حسب الخوارزمية للعمود الحلزوني (كأحد الأمثلة)
      pN = 0.85 * (fC * (aG - As) + fY * As);
      pN2 = pN * 0.85 * pow(10, -3);
    }

    setState(() {
      aGResult = aG;
      pNResult = pN2;
      pNResult = (pNResult! / 1000);
    });
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
///  tied 0.8   * 10 3-
/// spral 0.85
/// 
/// 
