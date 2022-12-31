import 'package:flutter/material.dart';
import 'package:live_streaming_pro_2/models/users.dart';

class UserProvider extends ChangeNotifier {
   Users _users = Users(
    uid: '',
    username: '',
    email: '',
  );
   Users get users=> _users;

  setUser(Users users){
    _users=users;
    notifyListeners();
  }
}
