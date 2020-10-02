import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final String locale;

  static DemoLocalizations of(BuildContext context) {
    return DemoLocalizations(Localizations.localeOf(context).languageCode);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'standardLabel': 'TextField',
      'standardHint':
          'When operating other interactive widgets,\nThe keyboard will not hide.',
      'normal': 'FocusWidget',
      'showFocusArea': 'Show the FocusWidget focus area',
      'onLostFocus': 'onLostFocus event',
      'alertTitle': 'Alert',
      'alertContent':
          'This TextField can not be empty\nTriggered by onLostFocus event',
      'button': 'Button',
    },
    'zh': {
      'standardLabel': 'TextField',
      'standardHint': '当与其它Widget进行交互式，\n键盘不会隐藏。',
      'normal': 'FocusWidget',
      'showFocusArea': '显示FocusWidget的焦点区域',
      'onLostFocus': 'onLostFocus事件',
      'alertTitle': '警告',
      'alertContent': '这个输入框不能为空\n通过onLostFocus事件触发',
      'button': '按钮',
    },
  };

  String get standardHint => _localizedValues[locale]['standardHint'];

  String get standardLabel => _localizedValues[locale]['standardLabel'];

  String get normal => _localizedValues[locale]['normal'];

  String get showFocusArea => _localizedValues[locale]['showFocusArea'];

  String get onLostFocus => _localizedValues[locale]['onLostFocus'];

  String get alertTitle => _localizedValues[locale]['alertTitle'];

  String get alertContent => _localizedValues[locale]['alertContent'];
  String get button => _localizedValues[locale]['button'];
}
