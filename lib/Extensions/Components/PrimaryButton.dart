import 'package:the_cake_land/Config/Theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, this.padding, this.text, this.press, this.textStyle})
      : super(key: key);
  final String? text;
  final TextStyle? textStyle;
  final Function? press;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        backgroundColor: MaterialStateProperty.all<Color>(ThemeColors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: ThemeColors.green),
          ),
        ),
      ),
      onPressed: press as void Function()?,
      child: Text(
        text!,
        style: textStyle ??
            TextStyle(
              fontSize: (18),
              color: Colors.white,
            ),
      ),
    );
  }
}
