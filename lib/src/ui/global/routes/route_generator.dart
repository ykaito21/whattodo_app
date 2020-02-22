import 'package:flutter/material.dart';
// import '../../../core/services/database_service.dart';
import '../../../app_localizations.dart';
import '../../screens/home_screen.dart';
import '../../screens/write_action_screen_wrapper.dart';

import '../style_list.dart';
import 'route_path.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutePath.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutePath.writeActionScreen:
        // if (args is ActionWithTags) {
        return MaterialPageRoute(
          builder: (context) => WriteActionScreenWrapper(
            actionWithTags: args,
          ),
        );
      // }
      // return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text(
              AppLocalizations.of(context).translate('error'),
              style: StyleList.baseTitleTextStyle,
            ),
          ),
        );
      },
    );
  }
}
