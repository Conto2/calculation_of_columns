import 'package:calculation_of_columns/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AnalysisRectangularColumnsScreen extends StatefulWidget {
  const AnalysisRectangularColumnsScreen({super.key});

  @override
  _ColumnAnalysisPageState createState() => _ColumnAnalysisPageState();
}

class _ColumnAnalysisPageState extends State<AnalysisRectangularColumnsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController bCtrl = TextEditingController();
  final TextEditingController hCtrl = TextEditingController();
  final TextEditingController CverCtrl = TextEditingController();
  final TextEditingController fyCtrl = TextEditingController();
  final TextEditingController fcCtrl = TextEditingController();
  final TextEditingController dpCtrl = TextEditingController();
  final TextEditingController beta1Ctrl = TextEditingController();
  final TextEditingController NCtrl = TextEditingController();
  final TextEditingController as2Ctrl = TextEditingController();
  final TextEditingController RCtrl = TextEditingController();
  final TextEditingController eCtrl = TextEditingController();

  // Constants (can be changed later to user inputs)
  // double fy = 420; // MPa
  // double fc = 30; // MPa
  double Es = 200000; // MPa
  // double beta1 = 0.85;
  double d2 = 60;

  // Results
  double Pnb = 0.0;
  // double Es = 0.0;
  double Mb = 0.0;
  double eb = 0.0;
  double Pn = 0.0;
  double fc = 0.0;
  double a = 0.0;
  // double Pb = 0.0;
  double m = 0.0;
  double rho = 0.0;
  double e2 = 0.0;
  double ab = 0.0;
  double N = 0.0;
  double Cver = 0.0;
  double db = 0.0;
  double d = 0.0;
  double As = 0.0;
  double beta1 = 0.0;
  double ff = 0.0;
  double com = 0.0;
  String lab = '';
  void calculate() {
    double fy = double.tryParse(fyCtrl.text) ?? 0.0;
    double fc = double.tryParse(fcCtrl.text) ?? 0.0;
    double b = double.tryParse(bCtrl.text) ?? 0.0;
    double h = double.tryParse(hCtrl.text) ?? 0.0;
    double Cver = double.tryParse(CverCtrl.text) ?? 0.0;
    double db = double.tryParse(dpCtrl.text) ?? 0.0;
    double N = double.tryParse(NCtrl.text) ?? 0.0;
    double beta1 = double.tryParse(beta1Ctrl.text) ?? 0.0;
    // double R = double.tryParse(RCtrl.text) ?? 0.0;
    double e = double.tryParse(eCtrl.text) ?? 0.0;

    // Step 1

    double d3 = h / 2 - d2;

    double Ab = (pi * pow(db, 2)) / 4;

    ///
    d = h - d2;

    ///

    As = (N / 2) * Ab;
//
    // Step 2
    double cb = (600 / (600 + fy)) * d;
    ab = beta1 * cb;

    // Step 3
    double epsS2 = 0.003 * (cb - d2) / cb;
    double fs2 = Es * epsS2;
    double epsy2 = fy / Es;
    if (epsS2 < epsy2) {
      ff = fs2;
    } else {
      ff = fy;
    }

    // Step 4
    double Cc = 0.85 * fc * ab * b;
    double T = As * fy;
    double Cs = As * (ff - 0.85 * fc);

    // Step 5
    Pnb = Cc + Cs - T;

    // Step 6
    //  Mb = Cc * (d - (a / 2) - d3) + Cs * (d - d2 - d3) + T * d3;
    //Mb = Cc * (d - (a / 2)) + Cs * (d - d2) - ((h / 2) - d2);
    //  eb = Mb / Pnb;
    eb = ((Cc * (d - (ab / 2)) + Cs * (d - d2)) / Pnb) - ((h / 2) - d2);

//////
    ///
    ///
    m = fy / (0.85 * fc);
    e2 = e + ((d - d2) / 2);
    rho = (As / (b * d));
    // Step

    if (e > eb) {
      // Tension control
      com = 1;
      lab = ' Tension control';
      print('1');
      Pn = 0.85 *
          fc *
          b *
          d *
          (-rho +
              1 -
              (e2 / d) +
              pow(
                  pow(1 - (e2 / d), 2) +
                      2 * rho * ((m - 1) * (1 - (d2 / d)) + (e2 / d)),
                  1 / 2));
    } else {
      // Compression controls
      com = 2;
      lab = 'Compression controls';
      print('2');
      // Pn = ((b * h * fc) / ((3 * h * e) / pow(d, 2)) + 1.18) +
      //     ((As * fy) / (e / (d - d2)) + 0.5);

      // Pn = ((b * h * fc) / ((3 * h * e) / pow(d, 2)) + 1.18) +
      //     ((As * fy) / (e / (d - d2)) + 0.5);

      Pn = (b * h * fc / ((3 * h * e / (d * d)) + 1.18)) +
          (As * fy / ((e / (d - d2)) + 0.5));
    }
    Pn = Pn / 1000;

    setState(() {});
  }

  void _clear() {
    setState(() {
      fyCtrl.text = '';
      fcCtrl.text = '';
      bCtrl.text = '';
      hCtrl.text = '';
      CverCtrl.text = '';
      NCtrl.text = '';
      dpCtrl.text = '';
      eCtrl.text = '';
      beta1Ctrl.text = '';
      RCtrl.text = '';
      Pn = 0.0;
      lab = '';
    });
    // asController.text = ' 0.0';
  }

  @override
  Widget build(BuildContext context) {
    double widt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Analysis Rectangular Columns')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildField(fyCtrl, 'fy : Mpa', widt / 2.5),
                  buildField(fcCtrl, 'fc : Mpa', widt / 2.5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildField(bCtrl, 'b (mm)', widt / 2.5),
                  buildField(hCtrl, 'h (mm)', widt / 2.5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildField(CverCtrl, ' cover (mm)', widt / 2.5),
                  buildField(NCtrl, 'N ', widt / 2.5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildField(dpCtrl, 'db\' (mm)', widt / 2.5),
                  buildField(eCtrl, 'e (mm)', widt / 2.5),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildField(beta1Ctrl, 'B 1 : %', widt / 2.5),
                  buildField(RCtrl, 'R : mm', widt / 2.5),
                ],
              ),
              SizedBox(height: 20),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        calculate();
                      }
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
              SizedBox(height: 30),
              ...[
                Text(
                  'Pn  = ${Pn.toStringAsFixed(2)} ',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    child: Text(
                  lab,
                  style: TextStyle(fontSize: 20),
                ))
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
      TextEditingController controller, String label, double widt) {
    return SizedBox(
      width: widt,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 20),
            border: OutlineInputBorder(),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) return 'مطلوب';
            if (double.tryParse(val) == null) return 'أدخل رقم صحيح';
            return null;
          },
        ),
      ),
    );
  }
}
