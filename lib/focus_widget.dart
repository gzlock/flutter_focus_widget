import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef FocusNodeBuilder = Widget Function(
    BuildContext context, FocusNode focusNode);
typedef OnLostFocus = bool Function(Widget widget);

class FocusWidget extends StatefulWidget {
  final FocusNode focusNode;
  final Widget child;
  final OnLostFocus onLostFocus;
  final bool justHideKeyboard;
  final bool showFocusArea;

  const FocusWidget({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.justHideKeyboard = false,
    this.showFocusArea = false,
    this.onLostFocus,
  })  : assert(child != null && focusNode != null),
        super(key: key);

  @override
  FocusWidgetState createState() => FocusWidgetState();

  static FocusWidget builder(
    BuildContext context, {
    @required FocusNodeBuilder builder,
    justHideKeyboard = false,
    showFocusArea = false,
    OnLostFocus onLostFocus,
  }) {
    final focusNode = FocusNode();
    return FocusWidget(
      focusNode: focusNode,
      justHideKeyboard: justHideKeyboard,
      showFocusArea: showFocusArea,
      onLostFocus: onLostFocus,
      child: builder(
        context,
        focusNode,
      ),
    );
  }
}

class FocusWidgetState extends State<FocusWidget> {
  OverlayEntry _overlayEntry;
  Rect rect;

  @override
  void initState() {
    super.initState();
//    widget.focusNode.addListener(update);
    widget.focusNode.addListener(update);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(update);
    super.dispose();
  }

  void update() {
    if (!widget.focusNode.hasFocus) return;
    final RenderBox renderBox = context.findRenderObject();
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    _createOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _createOverlay() {
    _removeOverlay();
    if (widget.focusNode.hasFocus) {
//      print('focus ${_focusNode.hasFocus} \n'
//          'topLeft:$topLeft \n'
//          'bottomRight: $bottomRight');
      bool canLostFocus = true;
      if (widget.onLostFocus != null) {
        canLostFocus = widget.onLostFocus(widget.child);
      }
      print('canLostFocus $canLostFocus');
      final children = <Widget>[
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (PointerDownEvent e) {
            if (widget.onLostFocus != null &&
                widget.onLostFocus(widget.child) == false) {
              return;
            }
            if (rect.contains(e.position) == false) {
              print('超出');
              if (widget.justHideKeyboard) {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              } else {
                widget.focusNode?.unfocus();
                _removeOverlay();
              }
            }
          },
          child: canLostFocus
              ? null
              : Container(
                  color: Colors.transparent,
                ),
        ),
      ];
      if (widget.showFocusArea) {
        children.insert(
            0,
            Positioned.fromRect(
              child: Container(
                color: Colors.red.withOpacity(0.2),
              ),
              rect: rect,
            ));
      }
      _overlayEntry = new OverlayEntry(
        builder: (context) {
          return Stack(
            children: children,
          );
        },
      );
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LayoutChangedNotification>(
      child: widget.child,
      onNotification: (LayoutChangedNotification notification) {
//        print('notification $notification');
        update();
        return true;
      },
    );
  }
}
