import 'package:flutter/material.dart';
import '../widgets/user_input_form.dart';
import './user_list_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Provider'),
        ),
        body: UserInputForm(),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        UserListScreen.route: (context) => const UserListScreen(),
      },
    );
  }
}
