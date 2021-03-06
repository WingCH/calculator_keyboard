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
      calculator.inputValue(CalculatorKeys.five);
      expect(calculator.equation, "11.5");
      calculator.inputValue(CalculatorKeys.decimal);
      expect(calculator.equation, "11.5");
    });

    test('test2', () {
      final calculator = Calculator();
      calculator.inputValue(CalculatorKeys.one);
      expect(calculator.equation, "1");

      calculator.inputValue(CalculatorKeys.add);
      expect(calculator.equation, "1+");

      calculator.inputValue(CalculatorKeys.two);
      expect(calculator.equation, "1+2");

      calculator.inputValue(CalculatorKeys.add);
      expect(calculator.result, 3.0);
    });

    test('test3', () {
      final calculator = Calculator();
      calculator.inputValue(CalculatorKeys.subtract);
      calculator.inputValue(CalculatorKeys.one);
      expect(calculator.equation, "-1");
      calculator.inputValue(CalculatorKeys.add);
      calculator.inputValue(CalculatorKeys.subtract);
      expect(calculator.equation, "-1-");
      calculator.inputValue(CalculatorKeys.two);
      expect(calculator.equation, "-1-2");
      calculator.inputValue(CalculatorKeys.add);
      expect(calculator.result, -3.0);
      expect(calculator.equation, "-3.0+");
      calculator.inputValue(CalculatorKeys.two);
      expect(calculator.equation, "-3.0+2");
      calculator.inputValue(CalculatorKeys.multiply);
      expect(calculator.equation, "-1.0x");
      calculator.inputValue(CalculatorKeys.two);
      expect(calculator.equation, "-1.0x2");
      calculator.inputValue(CalculatorKeys.add);
      expect(calculator.result, -2.0);
      expect(calculator.equation, "-2.0+");
    });
  });
}
