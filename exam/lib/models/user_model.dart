class User {
  final String name;
  // final String email;
  // final String password;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> parsedjson) {
    return User(
      name: parsedjson['name'],
      // email: parsedjson['email'],
      // password: parsedjson['password']
    );
  }
}
