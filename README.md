# Flutter Focus Widget

### 一个可以让FocusNode失去焦点的Widget

### A focusable and blurable widget of based on the FocusNode.

- 新增的参数：
    - bool showFocusArea
        使用一个半透明的红色方框显示焦点区域，主要用于调试。
    - void Function(Widget widget) onLostFocus 
        失去焦点后会调用这个function。

- New Parameters:
    - bool showFocusArea
        Display a translucent red box to show the focus area, it's for debug.
    - void Function(Widget widget) onLostFocus 
        When lost focus invoke this function.

- 当FocusWidget获得焦点后

    在FocusWidget区域外点击

    会调用FocusNode.unfocus()并且触发FocusNode的listener

- When the FocusWidget had focus

    Tap outside the FocusWidget area

    Will call the FocusNode's unfocus method and trigger the FocusNode's listener

## Code
```dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:focus_widget/focus_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale.fromSubtags(languageCode: 'zh'),
        Locale.fromSubtags(languageCode: 'en'),
      ],
      home: MyHomePage(title: 'Demo'),
    );
  }
}

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final String locale;

  static DemoLocalizations of(BuildContext context) {
    return DemoLocalizations(Localizations.localeOf(context).languageCode);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'normal': 'Normal',
      'showFocusArea': 'showFocusArea',
      'onLostFocus': 'onLostFocus event',
      'isEmpty': 'This input can not be empty',
    },
    'zh': {
      'normal': '正常模式',
      'showFocusArea': '显示半透明红色的焦点区域',
      'onLostFocus': 'onLostFocus事件',
      'isEmpty': '这个输入框不能为空',
    },
  };

  String get normal => _localizedValues[locale]['normal'];

  String get showFocusArea => _localizedValues[locale]['showFocusArea'];

  String get onLostFocus => _localizedValues[locale]['onLostFocus'];

  String get isEmpty => _localizedValues[locale]['isEmpty'];
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _address = FocusNode(), _name = FocusNode();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final language = DemoLocalizations.of(context);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 10, right: 10),
            children: ListTile.divideTiles(
                context: context,
                tiles: List.generate(20, (i) {
                  if (i != 5) {
                    return ListTile(title: Text(i.toString()));
                  }
                  return FocusWidget.builder(
                    context,
                    showFocusArea: true,
                    builder: (ctx, focusNode) => TextField(
                      focusNode: focusNode,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Input',
                        labelText: 'Input',
                      ),
                    ),
                  );
                })).toList(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: 100,
              child: FocusWidget(
                focusNode: _address,
                child: TextField(
                  focusNode: _address,
                  decoration: InputDecoration(
                      hintText: language.normal, labelText: language.normal),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: FocusWidget.builder(
                context,
                showFocusArea: true,
                builder: (_, FocusNode focusNode) => TextField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                      hintText: language.showFocusArea,
                      labelText: language.showFocusArea),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FocusWidget.builder(
              context,
              showFocusArea: true,
              onLostFocus: (_, focusNode) {
                print('input is empty: ${_email.text.isEmpty}');
                setState(() {});
              },
              builder: (context, FocusNode focusNode) {
                return TextField(
                  controller: _email,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: language.onLostFocus,
                    labelText: language.onLostFocus,
                    errorText: _email.text.isEmpty ? language.isEmpty : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### 录屏 / Screen Recording

![gif](https://github.com/gzlock/images/blob/master/focus_widget/English_2.gif?raw=true)