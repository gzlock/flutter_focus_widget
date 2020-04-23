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
          'and trigger the FocusNode listener\n',
      'parameters': 'Parameters: \n'
          '\t\t\tshowFocusArea: display a red rectangle it mean the focus area\n'
          '\t\t\tjustHideKeyboard: tap outside of the input, just hide the keyboard\n',
      'address': 'Address',
      'name': 'name',
      'justHide': 'Just hide the keyboard, keep it has focus'
    },
    'zh': {
      'tips': '当输入框获得焦点后，\n'
          '在FocusWidget域外触发PointerDown\n'
          '会让FocusWidget失去焦点'
          '并且触发FocusNode的listener',
      'parameters': '参数：\n'
          '\t\t\tshowFocusArea：显示一个淡红色方框高亮焦点区域\n'
          '\t\t\tjustHideKeyboard：隐藏键盘后让输入框保持获得焦点的样子',
      'address': '地址',
      'name': '名称',
      'justHide': '只隐藏键盘，保持焦点'
    },
  };

  String get address => _localizedValues[locale]['address'];

  String get name => _localizedValues[locale]['name'];

  String get tips => _localizedValues[locale]['tips'];

  String get justHide => _localizedValues[locale]['justHide'];

  String get parameters => _localizedValues[locale]['parameters'];
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
          SizedBox(
            height: 100,
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
//                    TextSpan(text: language.tips),
                    TextSpan(
                        text: language.parameters,
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ],
                ),
                style: TextStyle(fontSize: 18),
                textWidthBasis: TextWidthBasis.longestLine,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: 100,
              child: FocusWidget(
                showFocusArea: true,
                focusNode: _address,
                child: TextField(
                  focusNode: _address,
                  decoration: InputDecoration(
                      hintText: language.name, labelText: language.name),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: FocusWidget(
                focusNode: _name,
                child: TextField(
                  focusNode: _name,
                  decoration: InputDecoration(
                      hintText: language.address, labelText: language.address),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FocusWidget.builder(
              context,
              justHideKeyboard: true,
              builder: (context, FocusNode focusNode) => TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: language.justHide,
                  labelText: 'FocusWidget.builder',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FocusWidget.builder(
              context,
              onLostFocus: (_) {
                print('email is empty: ${_email.text.isEmpty}');
                return _email.text.isNotEmpty;
              },
              builder: (context, FocusNode focusNode) {
                return TextField(
                  controller: _email,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                  ),
                );
              },
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Open Drawer'),
            onPressed: () {
              _scaffold.currentState.openDrawer();
            },
          ),
        ],
      ),
    );
  }
}
