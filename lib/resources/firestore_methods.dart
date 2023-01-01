import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:live_streaming_pro_2/models/livestream.dart';
import 'package:live_streaming_pro_2/provider/user_provider.dart';
import 'package:live_streaming_pro_2/resources/storage_methods.dart';
import 'package:live_streaming_pro_2/utils/utils.dart';
import 'package:provider/provider.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    final users = Provider.of<UserProvider>(context, listen: false);
    String channelId = '';
    try {
      if (title.isNotEmpty && image != null) {
        if (!(await _firestore
                .collection('livestream')
                .doc(users.users.uid)
                .get())
            .exists) {
          String thumbnailUrl = await _storageMethods.uploadImageToStorage(
            'livestream-thumbnail',
            image,
            users.users.uid,
          );
          channelId = "${users.users.uid}${users.users.username}";
          LiveStream liveStream = LiveStream(
            title: title,
            image: thumbnailUrl,
            uid: users.users.uid,
            username: users.users.username,
            viewers: 0,
            channelId: channelId,
            startedAt: DateTime.now(),
          );

          _firestore
              .collection("livestream")
              .doc(channelId)
              .set(liveStream.toMap());
        }else{
          showSnakBar(context, 'Two livestream create');
        }
      } else {
        showSnakBar(context, "Please enter all the fields!");
      }
    } on FirebaseException catch (e) {
      showSnakBar(context, e.message!);
    }
    return channelId;
  }
}
