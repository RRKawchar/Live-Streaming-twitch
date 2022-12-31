import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:live_streaming_pro_2/provider/user_provider.dart';
import 'package:live_streaming_pro_2/resources/storage_methods.dart';
import 'package:live_streaming_pro_2/utils/utils.dart';
import 'package:provider/provider.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final StorageMethods _storageMethods=StorageMethods();
  startLiveStream(BuildContext context, String title, Uint8List? image) async {
    final users = Provider.of<UserProvider>(context, listen: false);
    try {
      if (title.isNotEmpty && image != null) {
       String thumbnailUrl=await _storageMethods.uploadImageToStorage('livestream-thumbnail', image, users.users.uid);
      }else{
        showSnakBar(context, "Please enter all the fields!");
      }
    } catch (e) {}
  }
}
