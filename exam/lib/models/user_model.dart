class User {
  final String? name;
  final String email;
  final String password;

  User({this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(name: json['name']? json['name']: "", email: json['email'], password: json['password']);
}