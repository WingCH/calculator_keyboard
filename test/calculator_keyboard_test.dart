import 'package:calculator_keyboard/src/calculator.dart';
import 'package:calculator_keyboard/src/calculator_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator', () {
    test('test', () {
      final calculator = Calculator();
      calculator.inputValue(CalculatorKeys.one);
      expect(calculator.equation, "1");
      calculator.inputValue(CalculatorKeys.one);
      expect(calculator.equation, "11");
      calculator.inputValue(CalculatorKeys.decimal);
      expect(calculator.equation, "11.");
    });
  });
}
