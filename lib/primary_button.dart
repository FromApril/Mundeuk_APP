import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.buttonText, required this.buttonFunction});

  final String buttonText;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(buttonText),
      style: getButtonStyle(context),
      onPressed: () => buttonFunction(),
    );
  }

  getButtonStyle(context) => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.lightBlue,
        fixedSize: Size(MediaQuery.of(context).size.width - 40, 47),
        textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      );
}
