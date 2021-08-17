import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class SettingsLocation extends BeamLocation<BeamState> {
  final RouteInformation info;

  SettingsLocation(this.info) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        title: 'Settings Screen',
        child: SettingsScreen(),
      ),
      if (state.pathBlueprintSegments.contains('profile'))
        const BeamPage(
          title: 'Profile Screen',
          child: ProfileScreen(),
        ),
    ];
  }

  @override
  List<Pattern> get pathBlueprints {
    return [
      '/settings',
      '/settings/profile',
      '/settings/profile/edit',
    ];
  }
}
