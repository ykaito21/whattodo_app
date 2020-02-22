import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../core/providers/write_action_screen_provider.dart';
import '../global/style_list.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';

class SubmitButtonWrapper extends StatelessWidget {
  const SubmitButtonWrapper({Key key}) : super(key: key);

  Future<void> _onPressed(
    BuildContext context,
    bool isUpdated,
    WriteActionScreenProvider writeActionScreenProvider,
  ) async {
    final bool res =
        writeActionScreenProvider.onPressdButton(context, isUpdated);
    if (res) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          StyleList.baseSnackBar(
              context, AppLocalizations.of(context).translate('wasSaved')),
        );
      await Future.delayed(
          Duration(milliseconds: 1000), () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final WriteActionScreenProvider writeActionScreenProvider =
        Provider.of<WriteActionScreenProvider>(context, listen: false);
    return StreamWrapper<bool>(
      stream: writeActionScreenProvider.checkUpdate(),
      onError: (context, _) {
        return BaseButton(
          onPressed: null,
          text: AppLocalizations.of(context).translate('error'),
        );
      },
      onWaitting: (context) {
        return BaseButton(
          onPressed: null,
          text: AppLocalizations.of(context).translate('edit'),
        );
      },
      onSuccess: (context, isUpdated) {
        return BaseButton(
          onPressed: () async =>
              await _onPressed(context, isUpdated, writeActionScreenProvider),
          text: isUpdated
              ? AppLocalizations.of(context).translate('save')
              : AppLocalizations.of(context).translate('edit'),
        );
      },
    );
  }
}
