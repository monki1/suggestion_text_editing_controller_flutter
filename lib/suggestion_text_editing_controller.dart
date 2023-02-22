// import 'dart:developer';
import 'package:flexible_text_editing_controller/flexible_text_editing_controller.dart';
import 'package:flutter/cupertino.dart';

class SuggestionsTextEditingController extends FlexibleTextEditingController{
  /// inputStyler & suggestionStyler are used to style input & suggestion text respectively
  /// set/get [input] & [suggestion] to access input & suggestion text
  /// set/get [cursorPosition] to access cursor position
  SuggestionsTextEditingController({required this.suggestionStyler, required TextSpan Function(String, TextStyle?) inputStyler}):
        super(styler: inputStyler, text: _separator);

  static const String _separator = "\u200b";
  String get suggestion {
    ///returns suggestion( text after separator)
    return text.substring(separatorIndex + 1);
  }
  Function(String) get suggestionSink => (String suggestion) => this.suggestion = suggestion;
  set suggestion(String suggestion) {
    int separatorIndex = text.indexOf(_separator);
    ///record & restore cursor position
    int baseOffset = cursorPosition;
    bool collapsed = selection.isCollapsed;
    int extentOffset = selection.extentOffset;
    text = text.substring(0, separatorIndex) + _separator + suggestion;
      if(collapsed){
        cursorPosition = baseOffset;
      }else {
        selection =
            TextSelection(baseOffset: baseOffset, extentOffset: extentOffset);
      }
  }

  String get input {
    return text.substring(0, separatorIndex);
  }
  set input(String newInput) {
    ///cursor position by default set to end of input
    text = newInput + _separator + suggestion;
    cursorPosition = separatorIndex;
  }
  set cursorPosition(int position) {
    selection = TextSelection.fromPosition(TextPosition(offset: position));
  }
  int get cursorPosition => selection.baseOffset;


  int get separatorIndex => text.indexOf(_separator);
  int lastIncomingBaseOffset = 0;
  //
  //cut text to before suggestion, use super.buildTextSpan
@override
  buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
///combine input & suggestion text spans provided by super/inputStyler & suggestionStyler
    TextSpan inputTextSpan = super.styler(input, style);
    TextSpan suggestionTextSpan = suggestionStyler(suggestion, style);
    return TextSpan(children: [inputTextSpan, suggestionTextSpan]);
  }

  TextSpan Function(String, TextStyle?) suggestionStyler;
  @override
  ///fix position of cursor to before suggestion
  set selection(TextSelection newSelection) {
    bool collapsed = newSelection.isCollapsed;
    int incomingBaseOffset = newSelection.baseOffset;
    int incomingExtentOffset = newSelection.extentOffset;

    ///IF is only active when moved outside of input by using arrow keys
    //dif incomingBaseOffset from last time
    int dif = incomingBaseOffset - lastIncomingBaseOffset;
    //set lastIncomingBaseOffset to incomingBaseOffset
    lastIncomingBaseOffset = incomingBaseOffset;
    //if dif.abs = 1 & collapsed & incomingBaseOffset > separatorIndex //then it's a cursor move outside of input
    if(dif.abs() == 1 && collapsed && incomingBaseOffset > separatorIndex) {
      // shift self.selection by dif unless lower then 0, get consumed by super.selection
      int newBaseOffset = cursorPosition + dif;
      newBaseOffset = newBaseOffset < 0 ? 0 : newBaseOffset;
      super.selection = TextSelection.fromPosition(TextPosition(offset: newBaseOffset));
    }
    ///if base or extent is outside of input, set to end of input
    // log("in-baseOffset: $incomingBaseOffset, extentOffset: $incomingExtentOffset, separatorIndex: $separatorIndex");
    if(incomingBaseOffset > separatorIndex) {
      incomingBaseOffset = separatorIndex;
    }
    if(incomingExtentOffset > separatorIndex) {
      incomingExtentOffset = separatorIndex;
    }
    if(collapsed){
      super.selection = TextSelection.fromPosition(TextPosition(offset: incomingBaseOffset));
    }else {
      super.selection =
          TextSelection(baseOffset: incomingBaseOffset, extentOffset: incomingExtentOffset);
    }
    // log("out-baseOffset: $incomingBaseOffset, extentOffset: $incomingExtentOffset, separatorIndex: $separatorIndex");

  }



}