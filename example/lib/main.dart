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
      'tips': 'When the FocusWidget has focus,\n'
          'Trigger the PointerDown event outside the FocusWidget area\n'
          'Will make FocusWidget lose focus\n'
          'and trigger the FocusNode listener',
      'address': 'Address',
      'name': 'name',
    },
    'zh': {
      'tips': '当输入框获得焦点后，\n'
          '在FocusWidget域外触发PointerDown\n'
          '会让FocusWidget失去焦点'
          '并且触发FocusNode的listener',
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
  final FocusNode _address = FocusNode(), _name = FocusNode();

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
              FocusWidget.builder(
                context,
                (ctx, focusNode) => TextField(
                  focusNode: focusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Input',
                    labelText: 'Input',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
