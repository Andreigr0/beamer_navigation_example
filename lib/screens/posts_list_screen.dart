import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts list'),
      ),
      body: ElevatedButton(
        onPressed: () {
          Beamer.of(context).beamToNamed('/posts/10');
        },
        child: Text('To post 10'),
      ),
    );
  }
}
