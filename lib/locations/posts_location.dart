import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../screens/post_details_screen.dart';
import '../screens/posts_list_screen.dart';

class PostLocation extends BeamLocation<BeamState> {
  final RouteInformation info;

  PostLocation(this.info) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        title: 'Posts List screen',
        child: PostsListScreen(),
      ),
      if (state.pathPatternSegments.contains('posts') &&
          state.pathParameters.containsKey('id'))
        BeamPage(
          key: ValueKey('Post-${state.pathParameters['id']}'),
          child: PostDetailsScreen(postId: state.pathParameters['id']!),
          title: 'Post #${state.pathParameters['id']}',
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns {
    return ['/posts', '/posts/:id'];
  }
}
