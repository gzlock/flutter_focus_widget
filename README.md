# Flutter Focus Widget

### 一个可以让FocusNode失去焦点的Widget

### A focusable and blurable widget of use the FocusNode.

- 当FocusWidget获得焦点后

    在FocusWidget域外触发PointerDown

    会让FocusWidget失去焦点

    并且触发FocusNode的listener

- When the FocusWidget has focus

    Trigger the PointerDown event outside the FocusWidget area

    Will make FocusWidget lose focus

    And trigger the FocusNode listener

### 录屏 / Screen Recording

![](https://github.com/gzlock/images/blob/master/focus_widget/1.gif?raw=true)