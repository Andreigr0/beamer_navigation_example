import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class HomeLocation extends BeamLocation<BeamState> {
  final RouteInformation info;

  HomeLocation(this.info) : super(info);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return const [BeamPage(child: HomeScreen())];
  }

  @override
  List<Pattern> get pathPatterns => ['/*'];
}
