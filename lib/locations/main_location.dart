import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      const BeamPage(
        key: ValueKey('not found'),
        child: Text('Not found'),
      ),
    ];
  }

  @override
  List<Pattern> get pathBlueprints => ['/404'];

}

class MainLocation extends BeamLocation<BeamState> {
  final RouteInformation info;

  MainLocation(this.info) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    if (Get.isRegistered<MainScreenController>()) {
      final c = Get.find<MainScreenController>();

      logger.i('Curr ${c.currentIndex}');
    }

    final String title2;
    if (state.pathBlueprintSegments.contains('settings')) {
      logger.i('settings');
      title2 = 'Settings';
    } else {
      title2 = 'Root Screen';
    }

    return [
      BeamPage(
        key: ValueKey('MainScreen'),
        title: title2,
        child: const MainScreen(),
      ),
      if (state.pathBlueprintSegments.contains('favorites'))
        const BeamPage(
          key: ValueKey('FavoritesScreen'),
          title: 'Favorites Screen',
          child: FavoritesScreen(),
        ),
      if (state.pathBlueprintSegments.contains('settings')) ...[
        if (state.pathBlueprintSegments.contains('profile')) ...[
          const BeamPage(
            key: ValueKey('ProfileScreen'),
            title: 'Profile Screen',
            child: ProfileScreen(),
          ),
          if (state.pathBlueprintSegments.contains('edit'))
            const BeamPage(
              key: ValueKey('ProfileEditScreen'),
              title: 'Profile Edit Screen',
              child: ProfileEditScreen(),
            ),
        ],
      ] else if (state.pathBlueprintSegments.contains('posts')) ...[
        if (state.pathParameters.containsKey('id'))
          BeamPage(
            key: ValueKey('Post-${state.pathParameters['id']}'),
            child: PostDetailsScreen(postId: state.pathParameters['id']!),
            title: 'Post #${state.pathParameters['id']}',
          ),
      ],
      if (state.pathBlueprintSegments.contains('login'))
        const BeamPage(
          key: ValueKey('LoginScreen'),
          title: 'Login Screen',
          child: LoginScreen(),
        ),
    ];
  }

  @override
  List<Pattern> get pathBlueprints {
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
