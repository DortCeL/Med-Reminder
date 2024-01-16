import 'package:flutter/material.dart';

class BMIpage extends StatefulWidget {
  const BMIpage({super.key});

  @override
  State<BMIpage> createState() => _BMIpage();
}

class _BMIpage extends State<BMIpage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  //default background color
  var bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.deepPurple,
          title: const Text(
            'Calculate BMI',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: bgColor,
          child: Center(
            child: Container(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BMI',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  TextField(
                    controller: wtController,
                    decoration: InputDecoration(
                        label: Text('Enter your Weight'),
                        prefixIcon: Icon(Icons.line_weight)),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: ftController,
                    decoration: InputDecoration(
                        label: Text('Enter your Height (in ft)'),
                        prefixIcon: Icon(Icons.height)),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  TextField(
                    controller: inController,
                    decoration: InputDecoration(
                        label: Text('Enter your height (in inch)'),
                        prefixIcon: Icon(Icons.height)),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var wt = wtController.text.toString();
                      var ft = ftController.text.toString();
                      var inch = inController.text.toString();

                      if (wt != "" && ft != "" && inch != "") {
                        // BMI calculation
                        var iWt = int.parse(wt);
                        var iFt = int.parse(ft);
                        var iInch = int.parse(inch);

                        var tInch = (iFt * 12) + iInch;
                        var tCm = tInch * 2.54;
                        var tM = tCm / 100;

                        var bmi = iWt / (tM * tM);

                        var msg = "";

                        if (bmi > 25) {
                          msg = "You are Overweight!";
                          bgColor = Colors.orange.shade200;
                        } else if (bmi < 18) {
                          msg = "You are Underweight!";
                          bgColor = Colors.red.shade200;
                        } else {
                          msg = "You are Healthy!";
                          bgColor = Colors.green.shade200;
                        }

                        setState(() {
                          result =
                              "$msg \nYour BMI is : ${bmi.toStringAsFixed((2))}";
                        });
                      } else {
                        setState(() {
                          bgColor = Colors.white;
                          result = "Please fill all the required blanks!";
                        });
                      }
                    },
                    child: Text('Calculate'),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
