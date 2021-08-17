import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/screens/posts_list_screen.dart';
import '/screens/settings_screen.dart';
import '../logger.dart';
import '../main.dart';
import '../screens/home_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// This is actually the same as [IndexedStack]
    /// But instead of showing one widget on another it shows them in row
    return Row(
      children: const [
        Expanded(child: HomeScreen()),
        Expanded(child: PostsListScreen()),
        Expanded(child: SettingsScreen()),
      ],
    );
  }
}

/// We also could use `GetResponsiveView<RootScreenController>`, but it doesn't
/// react to `update()` method, so in any case we have to use either
/// [GetBuilder], [MixinBuilder], [Getx] or [Obx] in order to update state
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      init: MainScreenController(),
      builder: (controller) {
        /// KeyedSubtree is IMPORTANT
        /// It is used to keep child's state if it wrapped with Row/Column
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
              actions: [
                ElevatedButton(
                  onPressed: () => Beamer.of(context).beamToNamed('/unknown'),
                  child: const Text('To unknown'),
                ),
              ],
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

class MainScreenController extends GetxController {
  final key = GlobalKey();

  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    routerDelegate.addListener(locationListener);
  }

  @override
  void onClose() {
    routerDelegate.removeListener(locationListener);
    super.onClose();
  }

  void locationListener() {
    final location = routerDelegate.currentConfiguration?.location ?? '';
    logger.d('Location $location, index: $currentIndex');

    if (location.startsWith('/posts')) {
      currentIndex = 1;
    } else if (location.startsWith('/settings')) {
      currentIndex = 2;
    } else {
      currentIndex = 0;
    }

    update();
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
      // rebuild: false,
    );

    if (value == currentIndex) {
      if (currentIndex == 1) {
      } else if (currentIndex == 2) {
      } else {}
    }

    currentIndex = value;
    update();
  }
}
