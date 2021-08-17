import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  final String postId;

  const PostDetailsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = int.parse(postId) + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post details screen $postId'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Beamer.of(context).beamToNamed('/posts/$id'),
            child: Text('Post $id'),
          ),
        ],
      ),
    );
  }
}
