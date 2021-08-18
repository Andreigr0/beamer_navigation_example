import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../logger.dart';
import '../screens/favorites_screen.dart';
import '../screens/login_screen.dart';
import '../screens/post_details_screen.dart';
import '../screens/profile_edit_screen.dart';
import '../screens/profile_screen.dart';
import 'main_screen.dart';

class NotFoundLocation extends BeamLocation<BeamState> {
  final RouteInformation? info;

  NotFoundLocation([this.info]) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('not found'),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Beamer.of(context).beamBack(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: const Text('Not found'),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/404'];
}

class MainLocation extends BeamLocation<BeamState> {
  final RouteInformation info;

  MainLocation(this.info) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final String rootTitle;

    if (state.pathPatternSegments.contains('settings')) {
      rootTitle = 'Settings';
    } else if (state.pathPatternSegments.contains('posts')) {
      rootTitle = 'Posts';
    } else {
      rootTitle = 'Home';
    }

    return [
      BeamPage(
        key: const ValueKey('MainScreen'),
        title: rootTitle,
        child: const MainScreen(),
      ),
      if (state.pathPatternSegments.contains('favorites'))
        const BeamPage(
          key: ValueKey('FavoritesScreen'),
          title: 'Favorites Screen',
          child: FavoritesScreen(),
        ),
      if (state.pathPatternSegments.contains('settings')) ...[
        if (state.pathPatternSegments.contains('profile')) ...[
          const BeamPage(
            key: ValueKey('ProfileScreen'),
            title: 'Profile Screen',
            child: ProfileScreen(),
          ),
          if (state.pathPatternSegments.contains('edit'))
            const BeamPage(
              key: ValueKey('ProfileEditScreen'),
              title: 'Profile Edit Screen',
              child: ProfileEditScreen(),
            ),
        ],
      ] else if (state.pathPatternSegments.contains('posts')) ...[
        if (state.pathParameters.containsKey('id'))
          BeamPage(
            key: ValueKey('Post-${state.pathParameters['id']}'),
            child: PostDetailsScreen(postId: state.pathParameters['id']!),
            title: 'Post #${state.pathParameters['id']}',
          ),
      ],
      if (state.pathPatternSegments.contains('login'))
        const BeamPage(
          key: ValueKey('LoginScreen'),
          title: 'Login Screen',
          child: LoginScreen(),
        ),
    ];
  }

  @override
  List<Pattern> get pathPatterns {
    return [
      '/',
      '/favorites',
      '/login',
      '/settings',
      '/settings/profile',
      '/settings/profile/edit',
      '/posts',
      '/posts/:id',
    ];
  }
}
