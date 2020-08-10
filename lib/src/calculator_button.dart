import 'package:flutter/material.dart';

import 'calculator_key_symbol.dart';

class CalculatorButton extends StatelessWidget {
  CalculatorButton({this.symbol, this.onTap});

  final CalculatorKeySymbol symbol;

  final Function(CalculatorKeySymbol symbol) onTap;

  Color get color {
    switch (symbol.type) {
      case CalculatorKeyType.FUNCTION:
        return Color(0xFF534053);

      case CalculatorKeyType.OPERATOR:
        return Color(0xFF534053);

      case CalculatorKeyType.INTEGER:
      default:
        return Color(0xFF443444);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: () => onTap(symbol),
        highlightColor: Colors.transparent,
        child: Center(
          child: symbol.icon == null
              ? Text(
                  symbol.value == "currency" ? "HKD" : symbol.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: symbol.value == "currency" ? 20 : 28,
                  ),
                )
              : Icon(
                  symbol.icon,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
