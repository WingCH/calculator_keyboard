import 'package:math_expressions/math_expressions.dart';

import 'calculator_key.dart';
import 'calculator_key_symbol.dart';

class Calculator {
  bool isPositive = true;
  String _numberA = "";
  String operator = "";
  String _numberB = "";

  double result = 0.0;

  String get numberA => _numberA;

  String get numberB => _numberB;

  // 算式 = (+/-) + numberA + operator + numberB, e,g: ( +1 + 2 ), ( -2 + 5)
  String get equation =>
      (isPositive == true ? "" : "-") + _numberA + operator + _numberB;

  void inputValue(CalculatorKeySymbol symbol) {
    switch (symbol.type) {
      case CalculatorKeyType.FUNCTION:
        if (symbol == CalculatorKeys.backspace) {
          backspace();
        }
        break;
      case CalculatorKeyType.OPERATOR:
        // "."
        if (symbol == CalculatorKeys.decimal) {
          if (numberA.isNotEmpty) {
            if (operator.isEmpty) {
              if (!checkDecimal(numberA)) {
                updateNumberA(symbol.value);
              }
            } else {
              if (numberB.isNotEmpty) {
                if (!checkDecimal(numberB)) {
                  updateNumberB(symbol.value);
                }
              }
            }
          }
        } else {
          // 符號
          if (numberA.isEmpty) {
            if (symbol == CalculatorKeys.add ||
                symbol == CalculatorKeys.subtract) {
              isPositive = (symbol == CalculatorKeys.add);
            }
          } else {
            if (operator.isEmpty) {
              operator = symbol.value;
            } else {
              if (numberB.isEmpty) {
                operator = symbol.value;
              } else {
                evaluate(onFinish: (result) {
                  updateResult(result);
                  operator = symbol.value;
                });
              }
            }
          }
        }
        break;
      case CalculatorKeyType.INTEGER:
        if (numberA.isEmpty) {
          updateNumberA(symbol.value);
        } else {
          if (operator.isEmpty) {
            updateNumberA(symbol.value);
          } else {
            updateNumberB(symbol.value);
          }
        }
        break;
    }
  }

  void evaluate({Function(double) onFinish}) {
    // 轉換數學符號，因為顯示和計算的符號不一樣
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

      onFinish(res);
    } catch (e) {
      print(e);
    }
  }

  void reset() {
    isPositive = true;
    _numberA = "";
    _numberB = "";
    operator = "";
  }

  void updateResult(double result) {
    this.result = result;
    isPositive = result > 0;

    // 如果result是負數，將result 變成正數，並將isPositive 變成 false
    if (!(result > 0)) {
      result = result * -1;
    }
    replaceNumberA(result.toString());
    replaceNumberB("");
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

  void replaceNumberA(String newNumber) {
    _numberA = newNumber;
  }

  void replaceNumberB(String newNumber) {
    _numberB = newNumber;
  }

  void backspace() {
    if (_numberB.isNotEmpty) {
      replaceNumberB(_numberB.substring(0, _numberB.length - 1));
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (_numberA.isNotEmpty) {
      replaceNumberA(_numberA.substring(0, _numberA.length - 1));
    }
  }
}
