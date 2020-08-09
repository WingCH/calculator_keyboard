//ref: https://github.com/kenreilly/flutter-calculator-demo
import 'package:flutter/cupertino.dart';

import 'calculator_key.dart';

enum CalculatorKeyType { FUNCTION, OPERATOR, INTEGER }

class CalculatorKeySymbol {
  const CalculatorKeySymbol(this.value, {this.icon});

  final String value;
  final IconData icon;

  static List<CalculatorKeySymbol> _operators = [
    CalculatorKeys.divide,
    CalculatorKeys.multiply,
    CalculatorKeys.subtract,
    CalculatorKeys.add,
    CalculatorKeys.decimal,
  ];

  static List<CalculatorKeySymbol> _functions = [
    CalculatorKeys.backspace,
    CalculatorKeys.clear,
    CalculatorKeys.currency,
    CalculatorKeys.equals,
    CalculatorKeys.keyboardHide,
    CalculatorKeys.equals,
  ];

  @override
  String toString() => value;

  bool get isOperator => _operators.contains(this);

  bool get isFunction => _functions.contains(this);

  bool get isInteger => !isOperator && !isFunction;

  CalculatorKeyType get type => isFunction
      ? CalculatorKeyType.FUNCTION
      : (isOperator ? CalculatorKeyType.OPERATOR : CalculatorKeyType.INTEGER);
}
