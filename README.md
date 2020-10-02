# Flutter Focus Widget

### 一个可以让FocusNode失去焦点的Widget

### A focusable and blurable widget of based on the FocusNode.

- 新增的参数：
    - bool showFocusArea
    
        使用一个半透明的红色方框显示焦点区域，主要用于调试。
        
    - void Function(Widget widget, FocusNode focusNode) onLostFocus 
    
        失去焦点后会调用这个function。

- New Parameters:
    - bool showFocusArea
    
        Display a translucent red box to show the focus area, it's for debug.
        
    - void Function(Widget widget, FocusNode focusNode) onLostFocus 
    
        When lost focus invoke this function.

- 当FocusWidget获得焦点后

    在FocusWidget区域外点击

    会调用FocusNode.unfocus()并且触发FocusNode的listener

- When the FocusWidget had focus

    Tap outside the FocusWidget area

    Will call the FocusNode's unfocus method and trigger the FocusNode's listener

### GIF

![gif](https://github.com/gzlock/images/blob/master/focus_widget/English_2.gif?raw=true)