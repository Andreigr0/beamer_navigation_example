import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../counter.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts list'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Beamer.of(context).beamToNamed('/posts/10'),
            child: const Text('To post 10'),
          ),
          const Counter()
        ],
      ),
    );
  }
}
