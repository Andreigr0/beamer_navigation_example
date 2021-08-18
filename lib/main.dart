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
  locationBuilder: (routeInformation, _) {
    final uri = Uri.parse(routeInformation.location ?? '/');
    final mainLocation = MainLocation(routeInformation);
    final canHandle = mainLocation.canHandle(uri);

    logger.i('Uri: $uri, canHandle: $canHandle');
    // if (!canHandle) {
    //   return NotFoundLocation(state);
    // }

    return mainLocation;
  },
  notFoundPage: const BeamPage(
    key: ValueKey('not found'),
    child: Text('Not found'),
  ),
  notFoundRedirectNamed: '/settings/profile',
  guards: [
    BeamGuard(
      pathPatterns: ['/settings/profile/edit'],
      beamToNamed: '/login',
      check: (context, location) => isLoggedIn,
    ),
    BeamGuard(
      pathPatterns: ['/posts/:id'],
      beamToNamed: '/login',
      check: (context, location) {
        logger.d('Check ${location.state}');

        return isLoggedIn;
      },
    ),
    BeamGuard(
      pathPatterns: ['/login'],
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
