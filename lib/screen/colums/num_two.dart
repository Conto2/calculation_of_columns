import 'dart:math';
import 'package:calculation_of_columns/widget/custom_button.dart';
import 'package:flutter/material.dart';

class DesignLoadedColumnScreen extends StatefulWidget {
  const DesignLoadedColumnScreen({super.key});

  @override
  _ColumnCalculatorPageState createState() => _ColumnCalculatorPageState();
}

class _ColumnCalculatorPageState extends State<DesignLoadedColumnScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers for inputs
  final TextEditingController puController = TextEditingController();
  final TextEditingController fyController = TextEditingController();
  final TextEditingController fcController = TextEditingController();
  final TextEditingController dbController = TextEditingController();
  // final TextEditingController asController = TextEditingController();
  final TextEditingController rController = TextEditingController();
  // final TextEditingController cController = TextEditingController();
  final TextEditingController rhoController = TextEditingController();
  final TextEditingController bController = TextEditingController();
  final TextEditingController hController = TextEditingController();
  final TextEditingController dController = TextEditingController();
  final TextEditingController abController = TextEditingController();
  int shapeValue = 0;
  // Output variables
  double Pu = 0.0;
  double Ag = 0.0;
  double Ag2 = 0.0;
  double rho = 0.0;
  double rho2 = 0.0;
  double Ast = 0.0;
  double N = 0.0;
  double s = 0.0;
  double b = 0.0;
  double h = 0.0;
  double d = 0.0;
  double phi = 0.0;
  double ab = 0.0;
  double R = 0.0;
  double db = 0.0;
  double c = 0.0;
  double fy = 0.0;
  double fc = 0.0;

  void calculateResults() {
    Pu = double.tryParse(puController.text) ?? 0.0;
    fy = double.tryParse(fyController.text) ?? 0.0;
    fc = double.tryParse(fcController.text) ?? 0.0;
    db = double.tryParse(dbController.text) ?? 0.0;
    // double as = double.parse(asController.text);
    R = double.tryParse(rController.text) ?? 0.0;
    // double c = double.parse(cController.text);
    rho = double.tryParse(rhoController.text) ?? 0.0;
    b = double.tryParse(bController.text) ?? 0.0;
    d = double.tryParse(dController.text) ?? 0.0;
    h = double.tryParse(hController.text) ?? 0.0;
    ab = double.tryParse(abController.text) ?? 0.0;

    if (shapeValue == 0) {
      // مستطيل
      c = 0.8;
      b = double.tryParse(bController.text) ?? 0.0;
      h = double.tryParse(hController.text) ?? 0.0;
      Ag2 = b * h;
      phi = 0.65;
    } else {
      // دائري
      c = 0.85;
      d = double.tryParse(dController.text) ?? 0.0;
      Ag2 = (pi * pow(d, 2)) / 4;
      phi = 0.75;
    }

    // Step 3: احسب Ag
    Ag = Pu / phi * c * (0.85 * fc + rho * (fy - 0.85 * fc));

    // Step 4: نحسب rho
    // rho = ((Pu / phi * c * Ag2) - 0.85 * fc) / (fy - 0.85 * fc);
    rho2 = ((Pu / (phi * c * Ag2)) - (0.85 * fc)) / (fy - 0.85 * fc);
    // Step 4: نحسب Ast
    Ast = rho2 * Ag2;

    // Step 5: عدد الأسياخ
    N = (Ast / ab).ceilToDouble();

    // Step 6: المسافة بين الأسياخ
    // s = min(
    //     min(16 * db, 48 * R),
    //     min(
    //       300,
    //       0.75 * sqrt(Ag!),
    //     )); // حماسي شوي
    double re1 = min(b, h);
    double re2 = 16 * db;
    double re3 = R * 48;
    s = min(re1, min(re2, re3));

    setState(() {
      // s = min(re1, min(re2, re3));
    });
  }

  void _clear() {
    setState(() {
      fyController.text = '';
      fcController.text = '';
      puController.text = '';
      dbController.text = '';
      hController.text = '';
      dController.text = '';
      dController.text = '';
      rController.text = '';
      rhoController.text = '';
      abController.text = '';
      bController.text = '';
      b = 0.0;
      h = 0.0;

      R = 0.0;
      N = 0.0;

      db = 0.0;
      s = 0.0;
    });
    // asController.text = ' 0.0';
  }

  @override
  Widget build(BuildContext context) {
    double widt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Design Axially Loaded Column')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // buildInput(dlController, "DL - Dead Load (kN)"),

              const Text(
                'Column Shape',
                style: TextStyle(fontSize: 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RadioListTile<int>(
                      title: const Text('Tied', style: TextStyle(fontSize: 20)),
                      value: 0,
                      groupValue: shapeValue,
                      onChanged: (val) {
                        setState(() {
                          shapeValue = val ?? 0;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<int>(
                      title:
                          const Text('Spiral', style: TextStyle(fontSize: 20)),
                      value: 1,
                      groupValue: shapeValue,
                      onChanged: (val) {
                        setState(() {
                          shapeValue = val ?? 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildInput(
                    puController,
                    "Pu : kn",
                    widt / 2.5,
                  ),
                  buildInput(
                    fyController,
                    "fy  : Mpa",
                    widt / 2.5,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildInput(
                    fcController,
                    "fc : Mpa",
                    widt / 2.5,
                  ),
                  buildInput(
                    dbController,
                    "db: mm",
                    widt / 2.5,
                  ),
                ],
              ),
              // buildInput(asController, "As - Area of Steel Bar (mm²)"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildInput(
                    rController,
                    "R : mm",
                    widt / 2.5,
                  ),
                  buildInput(
                    abController,
                    'Ab : mm2 ',
                    widt / 2.5,
                  ),
                ],
              ),
              buildInput(
                rhoController,
                'p',
                widt,
              ),
              // buildInput(
              //     cController, "c - Strength Reduction Factor (0.8 أو 0.85)"),
              const SizedBox(height: 20),
              // اختيارات الشكل

              if (shapeValue == 0) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildInput(
                      bController,
                      'b : mm',
                      widt / 2.5,
                    ),
                    buildInput(
                      hController,
                      'h : mm',
                      widt / 2.5,
                    ),
                  ],
                )
              ],
              // إذا كان الشكل دائري نظهر إدخال D
              if (shapeValue == 1) ...[
                buildInput(
                  dController,
                  'D : mm',
                  widt,
                ),
              ],

              const SizedBox(height: 20),

              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) calculateResults();
                    },
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
              const SizedBox(height: 20),
              // Text('b = $b'),
              // Text('h = $h'),
              // Text('R = $R'),
              // Text('N = $N'),
              // Text('db = $db'),
              // Text(' s = $s'),
              // Text(' rho = $rho2'),
              ...[
                resultItem("b", b, "mm"),
                resultItem("h", h, "mm"),
                resultItem("R", R, "mm"),
                resultItem("N", N, ""),
                resultItem("db", db, "mm"),
                resultItem("s", s, "mm c/c"),
                Text(
                  'the section is save ',
                  style: TextStyle(fontSize: 20),
                ),
                Text('the section is Eceonomic',
                    style: TextStyle(fontSize: 20)),
                //  ElevatedButton(onPressed: () {}, child: Text('cansel'))
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController controller, String label, widt) {
    // double widt = MediaQuery.of(context).size.width;
    //  final double widt;
    return Container(
      width: widt,
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 20),
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) => value == null || value.isEmpty ? 'مطلوب' : null,
        ),
      ),
    );
  }

  Widget resultItem(String label, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 20,
        children: [
          Text("$label:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(
            "${value.toStringAsFixed(2)} $unit",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
