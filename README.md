# Flutter Focus Widget

### 一个可以让FocusNode失去焦点的Widget

### A focusable and blurable widget of use the FocusNode.

- 当FocusWidget获得焦点后

    在FocusWidget区域外触发PointerDown事件

    会调用FocusNode.unfocus()并且触发FocusNode的listener

- When the FocusWidget had focus

    Tap this FocusWidget outside area

    Will call the FocusNode's unfocus method and trigger the FocusNode's listener

```dart
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
                    hintText: 'Input 1',
                    labelText: 'Input 1',
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
            Container(
              width: 100,
              child: FocusWidget(
                focusNode: _address,
                child: TextField(
                  focusNode: _address,
                  decoration: InputDecoration(
                      hintText: 'Input 2', labelText: 'Input 2'),
                ),
              ),
            ),
            FocusWidget(
              focusNode: _name,
              child: TextField(
                focusNode: _name,
                decoration: InputDecoration(
                    hintText: 'Input 3', labelText: 'Input 3'),
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
```

### 录屏 / Screen Recording

![gif](https://github.com/gzlock/images/blob/master/focus_widget/English_2.gif?raw=true)