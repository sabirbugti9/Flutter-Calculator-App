import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "";
      } else if (value == "=") {
        result = calculateResult(input);
      } else {
        input += value;
      }
    });
  }

  String calculateResult(String input) {
    try {
      List<String> parts = input.split(RegExp(r'([+\-*/])'));
      if (parts.length < 2) return "Error";
      double num1 = double.parse(parts[0]);
      double num2 = double.parse(parts[1]);
      String operator = input.replaceAll(RegExp(r'[0-9.]'), "");

      switch (operator) {
        case '+':
          return (num1 + num2).toString();
        case '-':
          return (num1 - num2).toString();
        case '*':
          return (num1 * num2).toString();
        case '/':
          return num2 != 0 ? (num1 / num2).toString() : "Error";
        default:
          return "Error";
      }
    } catch (e) {
      return "Error";
    }
  }

  Widget buildButton(String text, {Color color = const Color(0xFF1E1E1E)}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: color,
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(text,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("Sabir Calculator"),
      backgroundColor: Color(0xFF121212),

     ),
     body: Column(
      children: [
        InputText(input: input),
        ResultText(result: result),
        Column(
          children: [
            _fourthButtons(),
            _thirdButtons(),
            _secondButtons(),
            _firstButtons(),
            SizedBox(height: 40,),
          ],
        )
      ],
     ),
    );
  }
























  Row _fourthButtons() {
    return Row(children: [
      buildButton("7"),
      buildButton("8"),
      buildButton("9"),
      buildButton("/", color: Color(0xFFF57C00))
    ]);
  }

  Row _thirdButtons() {
    return Row(children: [
      buildButton("4"),
      buildButton("5"),
      buildButton("6"),
      buildButton("*", color: Color(0xFFF57C00))
    ]);
  }

  Row _secondButtons() {
    return Row(children: [
      buildButton("1"),
      buildButton("2"),
      buildButton("3"),
      buildButton("-", color: Color(0xFFF57C00))
    ]);
  }

  Row _firstButtons() {
    return Row(children: [
      buildButton("C", color: Color(0xFFD32F2F)),
      buildButton("0"),
      buildButton("=", color: Color(0xFF00E676)),
      buildButton("+", color: Color(0xFFF57C00))
    ]);
  }
}

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    required this.input,
  });

  final String input;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        child: Text(
          input.isEmpty ? "0" : input,
          style: TextStyle(
              fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class ResultText extends StatelessWidget {
  const ResultText({
    super.key,
    required this.result,
  });

  final String result;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        child: Text(
          result,
          style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00E676)),
        ),
      ),
    );
  }
}
