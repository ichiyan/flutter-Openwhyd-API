import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openwhyd_api_music_app/views/login.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => logout(context), icon: Icon(Icons.exit_to_app));
  }

  void logout(BuildContext context) async {
    final res = await http.get(Uri.parse('https://openwhyd.org/login?action=logout&ajax=true'));
    print('Logging out');
    if (res.statusCode == 200) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
      print('logged out...');
    } else {
      print('Failed to log out');
    }
  }
}
