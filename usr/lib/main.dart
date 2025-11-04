import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentInput = "0";
  double _num1 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _currentInput = "0";
        _num1 = 0;
        _operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        if (_operand.isNotEmpty && _currentInput != "0") {
          _calculate();
        }
        _num1 = double.parse(_currentInput);
        _operand = buttonText;
        _currentInput = "0";
      } else if (buttonText == ".") {
        if (!_currentInput.contains(".")) {
          _currentInput += ".";
        }
      } else if (buttonText == "=") {
        _calculate();
      } else {
        if (_currentInput == "0") {
          _currentInput = buttonText;
        } else {
          _currentInput += buttonText;
        }
      }
      _output = _currentInput;
    });
  }

  void _calculate() {
    if (_operand.isNotEmpty) {
      double num2 = double.parse(_currentInput);
      double result = 0;
      if (_operand == "+") {
        result = _num1 + num2;
      } else if (_operand == "-") {
        result = _num1 - num2;
      } else if (_operand == "×") {
        result = _num1 * num2;
      } else if (_operand == "÷") {
        if (num2 != 0) {
          result = _num1 / num2;
        } else {
          _currentInput = "Error";
          _num1 = 0;
          _operand = "";
          return;
        }
      }
      _currentInput = result.toString();
      if (result.toString().endsWith(".0")) {
        _currentInput = result.toInt().toString();
      }
      _num1 = result; 
      _operand = "";
    }
  }

  Widget _buildButton(
    String buttonText, {
    Color textColor = Colors.white,
    Color backgroundColor = const Color(0xFF333333),
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: const CircleBorder(),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildZeroButton(
    String buttonText, {
    Color textColor = Colors.white,
    Color backgroundColor = const Color(0xFF333333),
  }) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.fromLTRB(34, 20, 34, 20),
            shape: const StadiumBorder(),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("آلة حاسبة"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    _buildButton("C", backgroundColor: const Color(0xFFA5A5A5), textColor: Colors.black),
                    _buildButton("±", backgroundColor: const Color(0xFFA5A5A5), textColor: Colors.black),
                    _buildButton("%", backgroundColor: const Color(0xFFA5A5A5), textColor: Colors.black),
                    _buildButton("÷", backgroundColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("×", backgroundColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("-", backgroundColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("+", backgroundColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildZeroButton("0"),
                    _buildButton("."),
                    _buildButton("=", backgroundColor: Colors.orange),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
