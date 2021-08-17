import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Beamer.of(context, root: true).beamToNamed('/posts/12');
            },
            child: Text('To posts 12'),
          ),
          ElevatedButton(
            onPressed: () {
              Beamer.of(context, root: true).beamToNamed('/settings/profile');
            },
            child: Text('To profile'),
          )
        ],
      ),
    );
  }
}