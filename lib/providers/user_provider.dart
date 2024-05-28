import 'package:flutter/cupertino.dart';
import 'package:todo_list/models/user_model.dart';

class AuthProviders extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
