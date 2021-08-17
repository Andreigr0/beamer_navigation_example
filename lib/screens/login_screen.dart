import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login screen'),
      ),
      body: ElevatedButton(
        onPressed: () {
          isLoggedIn = true;
          Beamer.of(context).beamBack();
        },
        child: const Text('Do Login'),
      ),
    );
  }
}
