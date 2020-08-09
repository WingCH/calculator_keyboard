import 'package:calculator_keyboard/calculator_key.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String numberA = "";
  String numberB = "";
  String operator = "";

  // 算式 = numberA + operator + numberB, e,g: ( 1 + 2 ), ( 2 + 5)
  String equation() {
    return numberA + operator + numberB;
  }

  // all calculator Widget
  List<CalculatorKeyWidget> calculatorKeyItemList;

  void _onTap(CalculatorKeySymbol symbol) {
    switch (symbol.type) {
      case CalculatorKeyType.FUNCTION:
        if (symbol == CalculatorKeys.clear) {
          numberA = "";
          numberB = "";
          operator = "";
        }
        break;
      case CalculatorKeyType.OPERATOR:
        if (numberA.isEmpty) return;
        if (operator.isEmpty || numberB.isEmpty) {
          operator = symbol.value;
        } else {
          try {
            Map<String, String> operatorsMap = {
              "÷": "/",
              "x": "*",
              "−": "-",
              "+": "+"
            };
            Expression exp = (Parser()).parse(
              operatorsMap.entries.fold(
                equation(),
                (prev, elem) => prev.replaceAll(elem.key, elem.value),
              ),
            );
            double res = double.parse(
                exp.evaluate(EvaluationType.REAL, ContextModel()).toString());

            numberA = res.toString();
            numberB = "";
            operator = symbol.value;

//            widget.updateValue(_formatValue(double.parse(result)));
          } catch (e) {
            print(e);
          }
        }
        break;
      case CalculatorKeyType.INTEGER:
        if (numberA.isEmpty || operator.isEmpty) {
          numberA += symbol.value;
        } else {
          numberB += symbol.value;
        }
        break;
    }
    setState(() {});
  }

  void _hideKeyboard() {
    if (widget.focusNode?.hasFocus ?? false) {
      widget.focusNode.unfocus();
    }
  }

  void _onTapBackspace() {
    setState(() {
      if (numberB.isNotEmpty) {
        numberB = numberB.substring(0, numberB.length - 1);
      } else if (operator.isNotEmpty) {
        operator = "";
      } else if (numberA.isNotEmpty) {
        numberA = numberA.substring(0, numberA.length - 1);
      }
    });
    print('object');
  }

  void _onTapEquals(_) {
    Expression exp = (Parser()).parse("1.+1.1");
    print(exp);
  }

  @override
  void initState() {
    calculatorKeyItemList = [
      // line 1
      CalculatorKeyWidget(symbol: CalculatorKeys.divide, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.multiply, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.subtract, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.add, onTap: _onTap),
      // line 2
      CalculatorKeyWidget(symbol: CalculatorKeys.one, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.two, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.three, onTap: _onTap),
      CalculatorKeyWidget(
          symbol: CalculatorKeys.backspace, onTap: (_) => _onTapBackspace()),
      // line 3
      CalculatorKeyWidget(symbol: CalculatorKeys.four, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.five, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.six, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.clear, onTap: _onTap),
      // line 4
      CalculatorKeyWidget(symbol: CalculatorKeys.seven, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.eight, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.nine, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.currency, onTap: _onTap),
      // line 5
      CalculatorKeyWidget(symbol: CalculatorKeys.decimal, onTap: _onTap),
      CalculatorKeyWidget(symbol: CalculatorKeys.zero, onTap: _onTap),
      CalculatorKeyWidget(
          symbol: CalculatorKeys.keyboardHide, onTap: (_) => _hideKeyboard()),
      CalculatorKeyWidget(symbol: CalculatorKeys.equals, onTap: _onTapEquals),
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
                          equation(),
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
