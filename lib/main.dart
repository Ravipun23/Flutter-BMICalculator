import 'package:bmi/splashPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculate BMI',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(89, 90, 84, 1.0),
                fontSize: 20,
                fontStyle: FontStyle.italic),
          )),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weightController = TextEditingController();
  var feetController = TextEditingController();
  var inchController = TextEditingController();
  var background = const Color.fromRGBO(239, 238, 239, 1.0);
  var message = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            widget.title,
            style: const TextStyle(color: Color.fromRGBO(239, 238, 239, 1.0)),
          )),
          backgroundColor: const Color.fromRGBO(89, 90, 84, 1.0),
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Calculate Your BMI:",
                  style: TextStyle(
                      color: Color.fromRGBO(77, 79, 72, 1.0),
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Enter Your Weight in KG/s ",
                    ),
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: feetController,
                  decoration: const InputDecoration(
                      label: Text(
                        "Enter Your Height in Ft/s ",
                      ),
                      prefixIcon: Icon(Icons.height_outlined)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: inchController,
                  decoration: const InputDecoration(
                      label: Text(
                        "Enter Your Height in Inch/s ",
                      ),
                      prefixIcon: Icon(Icons.height_outlined)),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(77, 79, 72, 1.0),
                        side:
                            const BorderSide(color: Colors.orange, width: 0.5),
                        shape: const BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      var weight = weightController.text.toString();
                      var feet = feetController.text.toString();
                      var inch = inchController.text.toString();
                      setState(() {
                        if (weight != "" && feet != "" && inch != "") {
                          double bmi = calculateBmi(weight, feet, inch);
                          if (bmi >= 8 && bmi <= 25) {
                            message = "You are Healthy";
                            background = Colors.green;
                          } else if (bmi < 18) {
                            message = "You are Under-Weight";
                            background = Colors.yellowAccent;
                          } else {
                            message = "You are Over-Weight";
                            background = Colors.redAccent;
                          }
                          result = "Your BMI is: $bmi";
                        } else {
                          background = Colors.white;
                          result = "Please fill all the details";
                          message = '';
                        }
                      });
                    },
                    child: const Text(
                      "Calculate",
                      style: TextStyle(
                        color: Color.fromRGBO(239, 238, 239, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: background,
                  padding: const EdgeInsets.all(13),
                  child: Text(
                    "$message\n$result",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  double calculateBmi(weight, feet, inch) {
    var weightInInt = int.parse(weight);
    var feetInInt = int.parse(feet);
    var inchInInt = int.parse(inch);

    var totalInch = (feetInInt * 12) + inchInInt;
    var totalCm = totalInch * 2.54;
    var totalMeter = totalCm / 100;
    var result = (weightInInt / (totalMeter * totalMeter));
    String temp = result.toStringAsFixed(3);
    double bmi = double.parse(temp);
    return bmi;
  }
}
