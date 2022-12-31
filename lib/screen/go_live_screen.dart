import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                DottedBorder(
                  borderType: BorderType.RRect,
                    radius:const Radius.circular(10),
                    dashPattern:const [10,4],
                    strokeCap: StrokeCap.round,
                    color: buttonColor,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: buttonColor.withOpacity(.05),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    )
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
