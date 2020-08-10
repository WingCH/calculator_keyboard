import 'package:calculator_keyboard/src/calculator.dart';
import 'package:calculator_keyboard/src/calculator_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test 1', () {
    final calculator = Calculator();
    calculator.inputValue(CalculatorKeys.one);
    expect(calculator.numberA, "1");
  });



}
