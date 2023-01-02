import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/config/app_id.dart';
import 'package:live_streaming_pro_2/provider/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart' as RtcLocalView;

class BroadCastScreen extends StatefulWidget {
  final bool isBroadCaster;
  final String channelId;
  const BroadCastScreen(
      {Key? key, required this.isBroadCaster, required this.channelId})
      : super(key: key);

  @override
  State<BroadCastScreen> createState() => _BroadCastScreenState();
}

class _BroadCastScreenState extends State<BroadCastScreen> {
  late final RtcEngine _engine;
  List<int> remoteUid = [];
  @override
  void initState() {
    _initEngine();
    super.initState();
  }

  void _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: appId,
    ));

    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    if (widget.isBroadCaster) {
      _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    } else {
      _engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    }
    _joinChannel();
  }

  void _addListeners() {
    _engine.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      debugPrint('onJoinChannelSuccess $connection, $elapsed');
    }, onUserJoined: (RtcConnection connection, int uid, int elapsed) {
      debugPrint('onUserJoined $connection $uid $elapsed');
      remoteUid.add(uid);
    }, onUserOffline: (RtcConnection connection, uid, reason) {
      debugPrint('onUserOffline $connection $uid $reason');

      setState(() {
        remoteUid.removeWhere((element) => element == uid);
      });
    }, onLeaveChannel: (RtcConnection connection, stats) {
      debugPrint("onLeaveChannel $stats");
      setState(() {
        remoteUid.clear();
      });
    }));
  }

  void _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannelWithUserAccount(
      token: tempToken,
      channelId: "rrkkas",
      userAccount: Provider.of<UserProvider>(context, listen: false).users.uid,
    );
  }

  @override
  Widget build(BuildContext context) {

    final users=Provider.of<UserProvider>(context).users;
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _renderVideo(users)
          ],
        ),
      ),
    );
  }
  _renderVideo(users){
    return AspectRatio(aspectRatio: 16/9,

    );
  }
}
