import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/resources/firestore_methods.dart';
import 'package:live_streaming_pro_2/screen/broad_cast_screen.dart';
import 'package:live_streaming_pro_2/utils/colors.dart';
import 'package:live_streaming_pro_2/utils/utils.dart';
import 'package:live_streaming_pro_2/widgets/custom_button.dart';
import 'package:live_streaming_pro_2/widgets/custom_textfield.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  final TextEditingController _titleController = TextEditingController();

  Uint8List? image;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  goLiveStream() async {
    String channelId = await FirestoreMethods()
        .startLiveStream(context, _titleController.text, image);
    if (channelId.isNotEmpty) {
      // ignore: use_build_context_synchronously
      showSnakBar(context, "livestream has started successfully!");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BroadCastScreen(
            isBroadCaster: true,
            channelId: channelId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Uint8List? pickedImage = await pickImage();
                      if (pickedImage != null) {
                        setState(() {
                          image = pickedImage;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 20.0),
                      child: image != null
                          ? SizedBox(
                              height: 300,
                              child: Image.memory(image!),
                            )
                          : DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              color: buttonColor,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: buttonColor.withOpacity(.05),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      color: buttonColor,
                                      size: 40.0,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select your thumbnail",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(controller: _titleController)
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Custombutton(onTap: goLiveStream, text: "Go Live!"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
