import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ElevatedButton(
        onPressed: () {
          Beamer.of(context).beamToNamed('/settings/profile');
        },
        child: const Text('To profile'),
      ),
    );
  }
}
