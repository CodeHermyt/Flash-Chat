import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {this.colour, this.text, this.minWidth, @required this.onPressed});

  final Color colour;
  final String text;
  final Function onPressed;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        color: colour,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPressed,
          height: 45,
          minWidth: minWidth,
          child: Text(text),
        ),
      ),
    );
  }
}
