abstract class Person {
  final String name;
  final String password;

  const Person({
    required this.name,
    required this.password,
  });

  factory Person.fromJSON(Map<String, dynamic> user) {
    return User(
      name: user['name'],
      password: user['password'],
    );
  }

  @override
  String toString() {
    return "name: $name"
        "email: $password";
  }
}

class User extends Person {
  const User({
    required String name,
    required String password,
  }) : super(
          name: name,
          password: password,
        );

  const User.anonymous()
      : this(
          name: 'Joe',
          password: '1454',
        );
}
