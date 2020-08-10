import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'calculator_keyboard_field.dart';

/*
  KeyboardActions 會自帶上下padding, 10px 左右
 */
class CalculatorKeyboard extends StatefulWidget {
  final Function(BuildContext context, String val, bool hasFocus) builder;

  const CalculatorKeyboard({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  _CalculatorKeyboardState createState() => _CalculatorKeyboardState();
}

class _CalculatorKeyboardState extends State<CalculatorKeyboard> {
  final FocusNode _nodeText = FocusNode();

  final customNotifier = ValueNotifier<String>("0");

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText,
          displayActionBar: false,
          footerBuilder: (_) => CalculatorKeyboardField(
            context: context,
            notifier: customNotifier,
            focusNode: _nodeText,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // Auto-acquire keyboard focus at the init time
    if (_nodeText.canRequestFocus) {
      _nodeText.requestFocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Platform.isAndroid
          ? () async {
              if (_nodeText.hasFocus) {
                _nodeText.unfocus();
                return false;
              } else {
                return true;
              }
            }
          : null,
      // KeyboardActions 會自帶上下padding, 10px 左右
      child: KeyboardActions(
        disableScroll: true,
        config: _buildConfig(context),
        child: KeyboardCustomInput<String>(
          focusNode: _nodeText,
          notifier: customNotifier,
          builder: widget.builder,
        ),
      ),
    );
  }
}
