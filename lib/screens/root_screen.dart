import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logger.dart';
import '../locations/home_location.dart';
import '../locations/posts_location.dart';
import '../locations/settings_location.dart';
import '../main.dart';

final beamerHome = GlobalKey<BeamerState>();
final beamerPosts = GlobalKey<BeamerState>();
final beamerSettings = GlobalKey<BeamerState>();

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Beamer(
            key: beamerHome,
            routerDelegate: BeamerDelegate(
              locationBuilder: (routeInformation, _) =>
                  HomeLocation(routeInformation),
            ),
          ),
        ),
        Expanded(
          child: Beamer(
            key: beamerPosts,
            routerDelegate: BeamerDelegate(
              locationBuilder: (routeInformation, _) =>
                  PostLocation(routeInformation),

              /// Keep state if we navigate to URI from different
              /// navigator (Beamer), e.g.
              /// `Beamer.of(context).beamToNamed('/settings/profile')`
              updateFromParent: false,
            ),
          ),
        ),
        Expanded(
          child: Beamer(
            key: beamerSettings,
            routerDelegate: BeamerDelegate(
              locationBuilder: (routeInformation, _) =>
                  SettingsLocation(routeInformation),
            ),
          ),
        ),
      ],
    );
  }
}

/// We also could use `GetResponsiveView<RootScreenController>`, but it doesn't
/// react to `update()` method, so in any case we have to use either
/// [GetBuilder], [MixinBuilder], [Getx] or [Obx] in order to update state
class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootScreenController>(
      init: RootScreenController(),
      builder: (controller) {
        /// KeyedSubtree is IMPORTANT
        /// It is used to keep child state if it wrapped with Row/Column
        /// after initialization
        /// See: https://stackoverflow.com/a/56926508/9586934
        final body = KeyedSubtree(
          key: controller.key,
          child: const Body(),
        );

        if (context.isPhone) {
          /// Of course, we could make dedicated widgets to different screen
          /// sizes instead of combining all of the state in a single one
          return Scaffold(
            appBar: AppBar(
              title: const Text('Root scaffold'),
            ),
            body: body,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              onTap: (value) => controller.onTap(value, context),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Posts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('NOT PHONE Root scaffold'),
            centerTitle: true,
          ),
          body: Row(
            children: [
              NavigationRail(
                onDestinationSelected: (value) =>
                    controller.onTap(value, context),
                selectedIndex: controller.currentIndex,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite_border),
                    selectedIcon: Icon(Icons.favorite),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.bookmark_border),
                    selectedIcon: Icon(Icons.book),
                    label: Text('Posts'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.star_border),
                    selectedIcon: Icon(Icons.star),
                    label: Text('Settings'),
                  ),
                ],
              ),
              Expanded(child: body),
            ],
          ),
        );
      },
    );
  }
}

class RootScreenController extends GetxController {
  final key = GlobalKey();

  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    final location = routerDelegate.currentConfiguration?.location ?? '';

    if (location.startsWith('/posts')) {
      currentIndex = 1;
    } else if (location.startsWith('/settings')) {
      currentIndex = 2;
    } else {
      currentIndex = 0;
    }
    logger.d('Location $location, index: $currentIndex');
    routerDelegate.addListener(() {
      logger.i('Listen route ${routerDelegate.currentConfiguration?.location}');
    });
  }

  /// Pop to the first route in the navigator's ([Beamer])  stack
  void _pop(GlobalKey<BeamerState>? beamer) {
    beamer?.currentState?.routerDelegate.navigator
        .popUntil((route) => route.isFirst);
  }

  void onTap(int value, BuildContext context) {
    final String location;
    if (value == 1) {
      location = '/posts';
    } else if (value == 2) {
      location = '/settings';
    } else {
      location = '/';
    }

    Beamer.of(context).update(
      configuration: RouteInformation(location: location),
      rebuild: false,
    );

    if (value == currentIndex) {
      if (currentIndex == 1) {
        _pop(beamerPosts);
      } else if (currentIndex == 2) {
        _pop(beamerSettings);
      } else {
        _pop(beamerHome);
      }
    }

    currentIndex = value;
    update();
  }
}
