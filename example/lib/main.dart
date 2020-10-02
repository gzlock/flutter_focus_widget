import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:focus_widget/focus_widget.dart';

import 'localizations.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode myFocusNode = FocusNode();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();
  final TextEditingController _email = TextEditingController();
  bool checkBoxValue = true;

  Widget leftSideDrawer() {
    return Drawer(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = DemoLocalizations.of(context);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: leftSideDrawer(),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: TextField(
                minLines: 2,
                maxLines: 2,
                controller: TextEditingController(text:language.standardHint),
                decoration: InputDecoration(
                  hintText: language.standardHint,
                  labelText: language.standardLabel,
                ),
              ),
              subtitle: SizedBox(height: 16),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Interactive widgets'),
              subtitle: Wrap(
                children: [
                  RaisedButton(
                    child: Text(language.button),
                    onPressed: () {},
                  ),
                  Checkbox(
                    value: checkBoxValue,
                    onChanged: (value) => setState(
                      () {
                        checkBoxValue = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: FocusWidget(
                focusNode: myFocusNode,
                showFocusArea: false,
                child: TextField(
                  focusNode: myFocusNode,
                  decoration: InputDecoration(
                      hintText: language.normal, labelText: language.normal),
                ),
              ),
            ),
            ListTile(
              title: FocusWidget.builder(
                context,
                showFocusArea: true,
                builder: (_, FocusNode focusNode) => TextField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: language.showFocusArea,
                    labelText: language.showFocusArea,
                  ),
                ),
              ),
            ),
            ListTile(
              title: FocusWidget.builder(
                context,
                showFocusArea: false,
                onLostFocus: (_, focusNode) async {
                  print('input is empty: ${_email.text.isEmpty}');
                  if (_email.text.isNotEmpty) return;
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(language.alertTitle),
                          content: Text(language.alertContent),
                        );
                      });
                  focusNode.requestFocus();
                },
                builder: (context, FocusNode focusNode) {
                  return TextField(
                    controller: _email,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: language.onLostFocus,
                      labelText: language.onLostFocus,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 1000),
          ],
        ).toList(),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Page'),
      ),
      body: Center(child: Text('Empty Page')),
    );
  }
}
