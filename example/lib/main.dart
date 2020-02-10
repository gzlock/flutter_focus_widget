import 'package:flutter/material.dart';
import 'package:input/input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text('可以测试ListView滚动的情况'),
            ),
          ),
          Input(
            focusNode: _focusNode,
            decoration: InputDecoration(hintText: '地址', labelText: '地址'),
          ),
          Input(
            decoration: InputDecoration(hintText: '姓名', labelText: '姓名'),
          ),
          SizedBox(
            height: 1000,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('焦点'),
        onPressed: () {
          print('变换焦点 ${_focusNode.hasFocus}');
          if (_focusNode.hasFocus)
            _focusNode.unfocus();
          else
            FocusScope.of(context).requestFocus(_focusNode);
        },
      ),
    );
  }
}
