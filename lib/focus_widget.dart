import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef FocusNodeBuilder = Widget Function(
    BuildContext context, FocusNode focusNode);
typedef OnLostFocus = void Function(Widget widget, FocusNode focusNode);

class FocusWidget extends StatefulWidget {
  final FocusNode focusNode;
  final Widget child;
  final OnLostFocus onLostFocus;
  final bool showFocusArea;

  const FocusWidget({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.showFocusArea = false,
    this.onLostFocus,
  })  : assert(child != null && focusNode != null),
        super(key: key);

  @override
  FocusWidgetState createState() => FocusWidgetState();

  static FocusWidget builder(
    BuildContext context, {
    @required FocusNodeBuilder builder,
    showFocusArea = false,
    OnLostFocus onLostFocus,
  }) {
    final focusNode = FocusNode();
    return FocusWidget(
      focusNode: focusNode,
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
    widget.focusNode.addListener(update);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(update);
    super.dispose();
  }

  void update() {
    // print('update');
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
      // print('has focus');
      final children = <Widget>[
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (PointerDownEvent e) {
            // print('onPointerDown');
            if (rect.contains(e.position) == false) {
              // print('超出');
              widget.focusNode?.unfocus();
              if (widget.onLostFocus != null)
                widget.onLostFocus(widget.child, widget.focusNode);
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              _removeOverlay();
            }
          },
//          child: canLostFocus
//              ? null
//              : Container(
//                  color: Colors.transparent,
//                ),
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
        // print('notification $notification');
        update();
        return true;
      },
    );
  }
}
