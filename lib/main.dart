import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'locations/main_location.dart';
import 'logger.dart';

void main() => runApp(MyApp());

var _isLoggedIn = false.obs;

bool get isLoggedIn => _isLoggedIn.value;

set isLoggedIn(bool value) => _isLoggedIn.value = value;

final routerDelegate = BeamerDelegate(
  // initialPath: '/posts/25',
  /// Nested navigation
  // locationBuilder: (state) => RootLocation(state),
  /// Regular navigation
  locationBuilder: (state) => MainLocation(state),
  notFoundPage: const BeamPage(
    key: ValueKey('not found'),
    child: Text('Not found'),
  ),
  notFoundRedirectNamed: '/settings/profile',
  guards: [
    BeamGuard(
      pathBlueprints: ['/settings/profile/edit'],
      beamToNamed: '/login',
      check: (context, location) => isLoggedIn,
    ),
    BeamGuard(
      pathBlueprints: ['/posts/:id'],
      beamToNamed: '/login',
      check: (context, location) {
        logger.d('Check ${location.state}');

        return isLoggedIn;
      },
    ),
    BeamGuard(
      pathBlueprints: ['/login'],
      check: (context, location) => !isLoggedIn,
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      debugShowCheckedModeBanner: false,
      // initialBinding: BindingsBuilder.put(() => RootScreenController()),
    );
  }
}
