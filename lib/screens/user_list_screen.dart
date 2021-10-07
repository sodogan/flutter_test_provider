import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_list_provider.dart';

class UserListScreen extends StatelessWidget {
  static const String route = '/list';

  const UserListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building the User List Screen');

    final userList = Provider.of<UserListProvider>(
      context,
      listen: false,
    ).users.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final user = userList[index];
          return Consumer<UserListProvider>(
            builder: (context, innerUserListProvider, ch) => ListTile(
              leading: ch,
              title: Text('Name: ${user.name}'),
              subtitle: Text(user.password),
              trailing: IconButton(
                onPressed: () => innerUserListProvider.deleteUser(
                  index,
                ),
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ),
            child: CircleAvatar(
              child: Text(
                (index + 1).toString(),
              ),
            ),
          );
        },
        itemCount: userList.length,
      ),
    );
  }
}
