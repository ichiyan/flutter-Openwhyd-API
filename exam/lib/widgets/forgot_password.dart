import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openwhyd_api_music_app/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailTEC = TextEditingController();
  ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Forgot Password?'),
          content: CustomTextFormField(labelText: "Email Address", hintText: "Email Address", textEditingController: emailTEC, textInputType: TextInputType.emailAddress),
          actions: <Widget>[
            TextButton(
              onPressed: ()  {
                return Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                  final res = await http.get(Uri.parse('https://openwhyd.org/login?action=forgot&email=${emailTEC.text}&ajax=true'));
                  print(res.body);
                  Navigator.pop(context, 'Submit');
                },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Forgot Password?'),
    );
  }
}
