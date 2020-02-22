import 'package:flutter/material.dart';
import '../../global/style_list.dart';

class BaseButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BaseButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).accentColor,
      textColor: Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).accentColor.withOpacity(0.5),
      disabledTextColor: Theme.of(context).primaryColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        // side: BorderSide(
        //   color: Theme.of(context).accentColor,
        // ),
      ),
      child: Text(
        text,
        style: StyleList.buttonTextStyle,
      ),
    );
  }
}
