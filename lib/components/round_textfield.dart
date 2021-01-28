import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({this.hintText, this.onChanged});

  final String hintText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.black54),
        obscureText: false,
        onChanged: onChanged,
        decoration: InputDecoration(
          //labelText: 'Falana Dhimkana',
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black54,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
