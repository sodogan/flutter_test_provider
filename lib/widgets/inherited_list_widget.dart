import 'package:flutter/material.dart';
import '../model/user.dart';

class InheritedStateWidget extends StatefulWidget {
  final Widget child;

  const InheritedStateWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  InheritedStateWidgetState createState() => InheritedStateWidgetState();
}

class InheritedStateWidgetState extends State<InheritedStateWidget> {
  List<User> userList = [];

  void addUser({
    required String name,
    required String password,
  }) {
    print('Adding $name and $password');
    setState(() {
      userList.add(
        User(
          name: name,
          password: password,
        ),
      );
    });
  }
  //

  void deleteUser({
    required int index,
  }) {
    print('removing from userList index: $index');

    setState(() {
      userList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilding InheritedState $userList');
    return InheritedListWidget(
      userList: userList,
      child: widget.child,
      state: this,
    );
  }
}

class InheritedListWidget extends InheritedWidget {
  final List<User> userList;
  final InheritedStateWidgetState state;

  const InheritedListWidget({
    Key? key,
    required Widget child,
    required this.userList,
    required this.state,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant InheritedListWidget oldWidget) {
    bool isRebuild = userList.length != oldWidget.userList.length;
    return isRebuild;
  }

  static InheritedStateWidgetState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedListWidget>()
        ?.state;
  }
}
