import 'package:flutter/material.dart';
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
      home: MyHomePage(title: 'Focus Widget Demo Page'),
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
      'tips': 'When the TextField focused，\n'
          '1. Tap outside place of the TextField, will lost focus\n'
          '2. Scroll the ListView, will lost focus\n'
          '3. The FocusWidget at the Drawer had the same effect',
      'address': 'Address',
      'name': 'name',
    },
    'zh': {
      'tips': '当输入框获得焦点后，\n'
          '1. 点击输入框外的位置会失去焦点\n'
          '2. 滚动列表会失去焦点\n'
          '3. 在Drawer中的FocusWidget也一样有效',
      'address': '地址',
      'name': '名称',
    },
  };

  String get address => _localizedValues[locale]['address'];

  String get name => _localizedValues[locale]['name'];

  String get tips => _localizedValues[locale]['tips'];
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _address = FocusNode(),
      _name = FocusNode(),
      _drawerNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final language = DemoLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 10, right: 10),
            children: [
              FocusWidget(
                focusNode: _drawerNode,
                child: TextField(
                  focusNode: _drawerNode,
                  decoration:
                      InputDecoration(hintText: 'Input', labelText: 'Input'),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(language.tips),
              ),
            ),
            Container(
              width: 100,
              child: FocusWidget(
                focusNode: _address,
                child: TextField(
                  focusNode: _address,
                  decoration: InputDecoration(
                      hintText: language.address, labelText: language.address),
                ),
              ),
            ),
            FocusWidget(
              focusNode: _name,
              child: TextField(
                focusNode: _name,
                decoration: InputDecoration(
                    hintText: language.name, labelText: language.name),
              ),
            ),
            SizedBox(
              height: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
