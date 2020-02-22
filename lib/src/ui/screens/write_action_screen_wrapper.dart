import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../../core/providers/write_action_screen_provider.dart';
import 'write_action_screen.dart';

class WriteActionScreenWrapper extends StatelessWidget {
  final ActionWithTags actionWithTags;
  const WriteActionScreenWrapper({
    Key key,
    this.actionWithTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AppProvider, WriteActionScreenProvider>(
      create: (context) =>
          WriteActionScreenProvider(currentActionWithTags: actionWithTags),
      update: (context, appProvider, writeActionScreenProvider) =>
          writeActionScreenProvider..currentDatabase = appProvider.appDatabase,
      dispose: (context, writeActionScreenProvider) =>
          writeActionScreenProvider.dispose(),
      child: WriteActionScreen(),
    );
  }
}
