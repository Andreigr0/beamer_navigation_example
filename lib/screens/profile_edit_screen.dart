import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: ElevatedButton(
        onPressed: () {
          Beamer.of(context).popToNamed('/settings');
        },
        child: const Text('Go back to settings'),
      ),
    );
  }
}
