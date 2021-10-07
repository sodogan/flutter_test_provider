import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_list_provider.dart';
import '/widgets/inherited_list_widget.dart';
import '../model/user.dart';
import '../screens/user_list_screen.dart';

class UserInputForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? validateInput(String? value) {
    print('Inside the validate input function value:$value');
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  void navigateToList(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      UserListScreen.route,
//      arguments: arguments,
    )
        .then(
      (value) {
        print('The view is done $value');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Building the UserInputForm Screen');

    final _nameField = InputField(
      validateInput: validateInput,
      label: 'Your Name',
    );

    final _passwordField = InputField(
      validateInput: validateInput,
      label: 'Password',
    );

    return Card(
      elevation: 4,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _nameField,
            _passwordField,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AddUserTextButton(
                  name: _nameField,
                  password: _passwordField,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  child: TextButton(
                    onPressed: () => navigateToList(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.indigo,
                      ),
                    ),
                    child: Text(
                      'Goto List',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Consumer<UserListProvider>(
                builder: (BuildContext context,
                        UserListProvider userListProvider, child) =>
                    ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          (index + 1).toString(),
                        ),
                      ),
                      title:
                          Text('Name: ${userListProvider.users[index].name}'),
                      subtitle:
                          Text('${userListProvider.users[index].password}'),
                      trailing: IconButton(
                        onPressed: () => userListProvider.deleteUser(index),
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    );
                  },
                  itemCount: userListProvider.users.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddUserTextButton extends StatelessWidget {
  final InputField name;
  final InputField password;

  const AddUserTextButton({
    Key? key,
    required this.name,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userListprovider = Provider.of<UserListProvider>(context);
    final userList = userListprovider.users.toList();

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      child: TextButton(
        onPressed: () => userListprovider.addUser(
          name: name.inputValue,
          password: password.inputValue,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.indigo,
          ),
        ),
        child: Text(
          'Add User',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final Function validateInput;
  final controller = TextEditingController();

  InputField({
    Key? key,
    required this.label,
    required this.validateInput,
  }) : super(key: key);

  String get inputValue {
    return controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => validateInput(value),
        decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            )),
      ),
      //controller: na
    );
  }
}
