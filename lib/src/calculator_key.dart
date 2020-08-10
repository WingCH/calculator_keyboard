import 'package:flutter/material.dart';

import 'calculator_key_symbol.dart';

class CalculatorKeys {
  // OPERATOR
  static CalculatorKeySymbol divide = const CalculatorKeySymbol('÷');
  static CalculatorKeySymbol multiply = const CalculatorKeySymbol('x');
  static CalculatorKeySymbol subtract = const CalculatorKeySymbol('-');
  static CalculatorKeySymbol add = const CalculatorKeySymbol('+');

  // FUNCTION
  static CalculatorKeySymbol backspace =
      const CalculatorKeySymbol("backspace", icon: Icons.backspace);
  static CalculatorKeySymbol clear = const CalculatorKeySymbol('C');
  static CalculatorKeySymbol currency = const CalculatorKeySymbol('currency');
  static CalculatorKeySymbol equals =
      const CalculatorKeySymbol('=', icon: Icons.done);
  static CalculatorKeySymbol keyboardHide =
      const CalculatorKeySymbol('keyboardHide', icon: Icons.keyboard_hide);
  static CalculatorKeySymbol decimal = const CalculatorKeySymbol('.');

  // INTEGER
  static CalculatorKeySymbol zero = const CalculatorKeySymbol('0');
  static CalculatorKeySymbol one = const CalculatorKeySymbol('1');
  static CalculatorKeySymbol two = const CalculatorKeySymbol('2');
  static CalculatorKeySymbol three = const CalculatorKeySymbol('3');
  static CalculatorKeySymbol four = const CalculatorKeySymbol('4');
  static CalculatorKeySymbol five = const CalculatorKeySymbol('5');
  static CalculatorKeySymbol six = const CalculatorKeySymbol('6');
  static CalculatorKeySymbol seven = const CalculatorKeySymbol('7');
  static CalculatorKeySymbol eight = const CalculatorKeySymbol('8');
  static CalculatorKeySymbol nine = const CalculatorKeySymbol('9');
}


