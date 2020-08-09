import 'package:math_expressions/math_expressions.dart';

import 'calculator_key_symbol.dart';

class Calculator {
  bool _isPositive = true;
  String _numberA = "";
  String _numberB = "";
  String _operator = "";

  // 算式 = (+/-) + numberA + operator + numberB, e,g: ( +1 + 2 ), ( -2 + 5)
  String get equation =>
      (_isPositive == true ? "+" : "-") + _numberA + _numberB + _operator;

  set isPositive(bool value) {
    _isPositive = value;
  } // 計算

  set operator(String value) {
    _operator = value;
  }

  void inputValue(CalculatorKeySymbol symbol) {
    switch (symbol.type) {
      case CalculatorKeyType.FUNCTION:
        // TODO: Handle this case.
        break;
      case CalculatorKeyType.OPERATOR:
        // TODO: Handle this case.
        break;
      case CalculatorKeyType.INTEGER:
        _numberA += symbol.value;
        break;
    }
  }

  double evaluate() {
    Map<String, String> operatorsMap = {
      "÷": "/",
      "x": "*",
      "−": "-",
      "+": "+",
    };
    try {
      Expression exp = (Parser()).parse(
        operatorsMap.entries.fold(
          equation,
          (prev, elem) => prev.replaceAll(elem.key, elem.value),
        ),
      );

      double res = double.parse(
        exp.evaluate(EvaluationType.REAL, ContextModel()).toString(),
      );

      return res;
    } catch (e) {
      return 0.0;
//      throw e;
    }
  }

  void reset() {
    _isPositive = true;
    _numberA = "";
    _numberB = "";
    _operator = "";
  }

  bool checkDecimal(String value) {
    return value.contains(".");
  }

  void updateNumberA(String newNumber) {
    _numberA += newNumber;
  }

  void updateNumberB(String newNumber) {
    _numberB += newNumber;
  }

  void backspace() {
    if (_numberB.isNotEmpty) {
      updateNumberB(_numberB.substring(0, _numberB.length - 1));
    } else if (_operator.isNotEmpty) {
      operator = "";
    } else if (_numberA.isNotEmpty) {
      updateNumberA(_numberA.substring(0, _numberA.length - 1));
    }
  }
}
