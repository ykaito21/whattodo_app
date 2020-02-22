import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/providers/slot_screen_provider.dart';
import 'slot_screen.dart';

class SlotScreenWrapper extends StatelessWidget {
  const SlotScreenWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AppProvider, SlotScreenProvider>(
      create: (context) => SlotScreenProvider(),
      update: (context, appProvider, slotScreenProvider) =>
          slotScreenProvider..currentDatabase = appProvider.appDatabase,
      dispose: (context, slotScreenProvider) => slotScreenProvider.dispose(),
      child: SlotScreen(),
    );
  }
}
