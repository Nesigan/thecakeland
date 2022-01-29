import 'package:the_cake_land/Config/Theme.dart';
import 'package:flutter/material.dart';

class Clip extends StatelessWidget {
  Clip({Key? key, required this.text, this.selected = false}) : super(key: key);
  final String text;

  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? ThemeColors.green : ThemeColors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
        child: Text(text),
      ),
    );
  }
}
