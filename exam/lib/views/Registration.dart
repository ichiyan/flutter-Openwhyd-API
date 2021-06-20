import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/mixins/ValidationMixin.dart';
import 'package:openwhyd_api_music_app/widgets/CustomTextFormField.dart';
import 'package:openwhyd_api_music_app/widgets/PasswordField.dart';
import 'package:openwhyd_api_music_app/widgets/PrimaryButton.dart';
import 'package:openwhyd_api_music_app/widgets/SecondaryButton.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

import 'Login.dart';

class Registration extends StatefulWidget {
  static const String routeName = "registration";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> with ValidationMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  bool obscureText = true;
  String selected = "Civilian";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: "Full Name",
                      hintText: "Enter full name",
                      iconData: Icons.person,
                      textEditingController: fullNameTextController,
                      textInputType: TextInputType.name,
                      validation: validateName,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      labelText: "Email Address",
                      hintText: "Enter a valid email",
                      iconData: Icons.mail_rounded,
                      textEditingController: emailTextController,
                      textInputType: TextInputType.emailAddress,
                      validation: validateEmail,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                      labelText: "Password",
                      hintText: "Enter password",
                      textEditingController: passwordTextController,
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      validation: validatePassword,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                      text: "Sign up",
                      iconData: Icons.app_registration,
                        onPress: () {
                          createUser(fullNameTextController.text, emailTextController.text, passwordTextController.text)
                              .then((value) {
                                print('pushing');
                              }).catchError((error) {
                                print(error);
                          });

                        },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecondaryButton(
                          text: "Already have an account? Login",
                          onPress: () {
                            navigateToLogin(context);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SecondaryButton(
                          text: "Post Something",
                          onPress: () {
                            Future<Album> album = createAlbum("CREATE TEST");
                            print(album);
                            album.then((value) {print(value.title);});

                            album = fetchAlbum();
                            print(album);
                            album.then((value) {print(value.title);});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(BuildContext context, name, email, password)
  {
    if (formKey.currentState!.validate()) {
      print("Valid Inputs");
      print(password);
      password = crypto.md5.convert(utf8.encode(password)).toString();
      print(password);
      print("Registering...");
      Future<User> user = createUser(name, email, password);
      user.then((data) { print(data.name);});

      Navigator.pushReplacementNamed(context, Login.routeName);
    } else {
      print("Invalid");
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, Login.routeName);
  }
}

class User {
  final String? name;
  final String email;
  final String password;

  User({this.name, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(name: json['name']? json['name']: "", email: json['email'], password: json['password']);
}

Future<User> createUser(String name, String email, String password) async{
  final response = await http.post(
    Uri.parse('https://openwhyd.org/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept" : "application/json",
      "followRedirects": "false",
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
    }),

  );

  print(response.request);
  if (response.statusCode == 201) {
    print(response.statusCode);
    return User.fromJson(jsonDecode(response.body));
  } else if(response.statusCode == 302) {
    print(response.statusCode);
    final res =
    await http.get(Uri.parse('https://openwhyd.org/${response.headers["location"]}'),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept" : "application/json",
  });

    print(res.request);
    print(res.statusCode);
    print(res.headers["location"]);
    print(res.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }else {
    throw Exception('Failed to create user.');
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
