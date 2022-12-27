import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';
class Custombutton extends StatelessWidget {
  const Custombutton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              maximumSize: const Size(double.infinity, 40)),
          onPressed: onTap,
          child: Text(text)),
    );
  }
}
