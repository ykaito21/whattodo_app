import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/providers/actions_screen_provider.dart';
import 'actions_screen.dart';

class ActionsScreenWrapper extends StatelessWidget {
  const ActionsScreenWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AppProvider, ActionsScreenProvider>(
      create: (context) => ActionsScreenProvider(),
      update: (context, appProvider, actionsScreenProvider) =>
          actionsScreenProvider..currentDatabase = appProvider.appDatabase,
      dispose: (context, actionsScreenProvider) =>
          actionsScreenProvider.dispose(),
      child: ActionsScreen(),
    );
  }
}
