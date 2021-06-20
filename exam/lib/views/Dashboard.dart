import 'package:flutter/material.dart';

import 'Registration.dart';

class Dashboard extends StatelessWidget {
  static const String routeName = "Dashboard";

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)!.settings);
    print(ModalRoute.of(context)!.settings.arguments);
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Container(
          child: Text('This is the dashboard. ${user.email}'),
        ),
      ),
    );
  }
}
