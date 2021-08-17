import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_edit_screen.dart';
import '../screens/root_screen.dart';

class RootLocation extends BeamLocation<BeamState> {
  final RouteInformation info;

  RootLocation(this.info) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        title: 'Root Screen',
        // child: RootScreen(),
        child: RootScreen(),
      ),
      if (state.pathBlueprintSegments.contains('edit'))
        const BeamPage(
          title: 'Profile Edit Screen',
          child: ProfileEditScreen(),
        ),
      if (state.pathBlueprintSegments.contains('login'))
        const BeamPage(
          title: 'Login Screen',
          child: LoginScreen(),
        ),
      if (state.pathBlueprintSegments.contains('favorites'))
        const BeamPage(
          title: 'Favorites Screen',
          child: FavoritesScreen(),
        ),
    ];
  }

  @override
  List<Pattern> get pathBlueprints {
    return [
      '/*',
      '/login',
      '/settings/profile/edit',
      '/favorites',
    ];
  }
}
