import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Beamer.of(context).beamToNamed('/settings/profile/edit');
            },
            icon: const Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
      body: ElevatedButton(
        onPressed: () {
          Beamer.of(context, root: true).beamToNamed('/settings/profile/edit');
        },
        child: const Text('Go to edit profile'),
      ),
    );
  }
}