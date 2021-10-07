import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/providers/user_list_provider.dart';
import './screens/my_home_page.dart';
import './providers/user_list_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserListProvider(),
      child: const MyHomePage(),
    ),
  );
}
