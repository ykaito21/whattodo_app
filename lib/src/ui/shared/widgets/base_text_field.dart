import 'package:flutter/material.dart';
import '../../global/style_list.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function onChanged;
  final String hintText;
  final TextStyle textStyle;
  final int maxLength;
  final FocusNode focusNode;
  const BaseTextField({
    Key key,
    @required this.textEditingController,
    @required this.onChanged,
    @required this.hintText,
    @required this.textStyle,
    this.maxLength,
    this.focusNode,
  })  : assert(textEditingController != null),
        assert(onChanged != null),
        assert(hintText != null),
        assert(textStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      expands: true,
      maxLines: null,
      maxLength: maxLength,
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: StyleList.allPadding10,
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        counterText: '',
      ),
      style: textStyle,
    );
  }
}
