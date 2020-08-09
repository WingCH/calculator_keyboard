import 'package:calculator_keyboard/calculator_key.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculator.dart';
import 'calculator_button.dart';
import 'calculator_key_symbol.dart';

// ref: https://github.com/ShehriyarShariq/FlutterCalculator
class CalculatorKeyboardField extends StatefulWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final BuildContext context;
  final ValueNotifier<String> notifier;
  final FocusNode focusNode;
  static const double _kKeyboardHeight = 308.75;
  static const double _kCustomToolbarHeight = 30.0;

  CalculatorKeyboardField({
    Key key,
    this.context,
    this.notifier,
    this.focusNode,
  }) : super(key: key);

  @override
  __CalculatorKeyboardState createState() => __CalculatorKeyboardState();

  @override
  Size get preferredSize => Size.fromHeight(
        CalculatorKeyboardField._kKeyboardHeight +
            CalculatorKeyboardField._kCustomToolbarHeight +
            MediaQuery.of(context).padding.bottom,
      );
}

class __CalculatorKeyboardState extends State<CalculatorKeyboardField> {
  Calculator calculator = Calculator();

  // 算式 = numberA + operator + numberB, e,g: ( 1 + 2 ), ( 2 + 5)
  String equation() {
//    return numberA + operator + numberB;
  }

  // all calculator Widget
  List<CalculatorButton> calculatorKeyItemList;

  void _onTap(CalculatorKeySymbol symbol) {
    setState(() {
      calculator.inputValue(symbol);
    });
  }

  void _hideKeyboard() {
    if (widget.focusNode?.hasFocus ?? false) {
      widget.focusNode.unfocus();
    }
  }

  void _onTapEquals(_) {
    Expression exp = (Parser()).parse("1.+1.1");
    print(exp);
  }

  @override
  void initState() {
    calculatorKeyItemList = [
      // line 1
      CalculatorButton(symbol: CalculatorKeys.divide, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.multiply, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.subtract, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.add, onTap: _onTap),
      // line 2
      CalculatorButton(symbol: CalculatorKeys.one, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.two, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.three, onTap: _onTap),
      CalculatorButton(
          symbol: CalculatorKeys.backspace,
          onTap: (_) => calculator.backspace()),
      // line 3
      CalculatorButton(symbol: CalculatorKeys.four, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.five, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.six, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.clear, onTap: _onTap),
      // line 4
      CalculatorButton(symbol: CalculatorKeys.seven, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.eight, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.nine, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.currency, onTap: _onTap),
      // line 5
      CalculatorButton(symbol: CalculatorKeys.decimal, onTap: _onTap),
      CalculatorButton(symbol: CalculatorKeys.zero, onTap: _onTap),
      CalculatorButton(
          symbol: CalculatorKeys.keyboardHide, onTap: (_) => _hideKeyboard()),
      CalculatorButton(symbol: CalculatorKeys.equals, onTap: _onTapEquals),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //TODO: 圓角會有底色
//      clipBehavior: Clip.antiAlias,
//      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF534053),
        ),
        child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 30,
                  color: Color(0xFF534053),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          calculator.equation,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                GridView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio:
                          ((MediaQuery.of(context).size.width / 4) /
                              ((CalculatorKeyboardField._kKeyboardHeight) / 5)),
                    ),
                    children: calculatorKeyItemList.map<Widget>((e) {
                      return e;
                    }).toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//String evaluateEquation() {
//    try {
//      // Fix equation
//      Expression exp = (Parser()).parse(
//        operatorsMap.entries.fold(
//          equation,
//          (prev, elem) => prev.replaceAll(elem.key, elem.value),
//        ),
//      );
//
//      debugPrint(exp.toString());
//
//      double res = double.parse(
//          exp.evaluate(EvaluationType.REAL, ContextModel()).toString());
//
//      // Output correction for decimal results
//      result = double.parse(res.toString()) == int.parse(res.toStringAsFixed(0))
//          ? res.toStringAsFixed(0)
//          : res.toStringAsFixed(4);
//
//      equation = result;
//
//      widget.updateValue(_formatValue(double.parse(result)));
//    } catch (e) {
//      result = "Error";
//    }
//}

//String _formatValue(double value) {
//  return FlutterMoneyFormatter(amount: value).output.nonSymbol;
//}
