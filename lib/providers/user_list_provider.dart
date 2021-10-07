import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import '../model/user.dart';

class UserListProvider with ChangeNotifier {
  List<User> _userList = [];

  addUser({
    required String name,
    required String password,
  }) {
    _userList.add(
      User(
        name: name,
        password: password,
      ),
    );
    notifyListeners();
  }

  deleteUser(int index) {
    _userList.removeAt(index);
    notifyListeners();
  }

  UnmodifiableListView<User> get users => UnmodifiableListView(_userList);
}
