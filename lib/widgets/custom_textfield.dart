import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: buttonColor.withOpacity(.09),
          ),
        ),
      ),
    );
  }
}
