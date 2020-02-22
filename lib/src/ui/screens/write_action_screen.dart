import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../core/providers/app_provider.dart';
import '../../core/providers/write_action_screen_provider.dart';
import '../../core/services/database_service.dart';
import '../shared/widgets/base_text_field.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../shared/platform/platform_alert_dialog.dart';
import '../widgets/submit_button_wrapper.dart';
import '../widgets/tag_list.dart';
import '../global/style_list.dart';

class WriteActionScreen extends StatelessWidget {
  const WriteActionScreen({Key key}) : super(key: key);

  Future<void> _onPressedDelete(
    BuildContext context,
    AppProvider appProvider,
    ActionWithTags currentActionWithTags,
  ) async {
    final String actionName = currentActionWithTags.action.name;
    final bool res = await PlatformAlertDialog(
      title: StyleList.localizedAlertTtile(context, actionName),
      content:
          '${AppLocalizations.of(context).translate('alertDeleteContentAction')}',
      defaultActionText: AppLocalizations.of(context).translate('delete'),
      cancelActionText: AppLocalizations.of(context).translate('cancel'),
    ).show(context);
    if (res) {
      appProvider.deleteActionWithTags(currentActionWithTags);
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          StyleList.baseSnackBar(context,
              '"$actionName" ${AppLocalizations.of(context).translate('wasDeleted')}'),
        );
      await Future.delayed(
          Duration(milliseconds: 1000), () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final WriteActionScreenProvider writeActionScreenProvider =
        Provider.of<WriteActionScreenProvider>(context, listen: false);
    final ActionWithTags currentActionWithTags =
        writeActionScreenProvider.currentActionWithTags;

    final double deviseHeight = MediaQuery.of(context).size.height;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    // kToolbarHeight
    final double appBarHeight = 56.0;
    // _kTabBarHeight
    // final double bottomNavHeight = 50.0;
    final double wrapperHeight =
        deviseHeight - (topPadding + bottomPadding + appBarHeight);
    final bool isNew = writeActionScreenProvider.isNew();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNew
              ? AppLocalizations.of(context).translate('newAction')
              : AppLocalizations.of(context).translate('editAction'),
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              height: wrapperHeight,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 160.0,
                    ),
                    padding: StyleList.horizontalPadding20,
                    child: BaseTextField(
                      textEditingController:
                          writeActionScreenProvider.nameController,
                      onChanged: (String newVal) => writeActionScreenProvider
                          .checkTextFieldUpdate(newVal, 'name'),
                      hintText:
                          AppLocalizations.of(context).translate('actionName'),
                      textStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLength: 50,
                      focusNode: writeActionScreenProvider.nameFocusNode,
                    ),
                  ),
                  StyleList.verticalBox10,
                  Container(
                    height: 150.0,
                    child: StreamWrapper<List<Tag>>(
                      stream: appProvider.streamTags(),
                      onSuccess: (context, List<Tag> tags) {
                        return SingleChildScrollView(
                          padding: StyleList.verticalHorizontalPaddding1020,
                          child: TagList(
                            tags: tags,
                            editable: true,
                            selectedTags: writeActionScreenProvider.initialTags,
                            provider: writeActionScreenProvider,
                          ),
                        );
                      },
                    ),
                  ),
                  StyleList.verticalBox10,
                  Expanded(
                    child: Padding(
                      padding: StyleList.horizontalPadding20,
                      child: BaseTextField(
                        textEditingController:
                            writeActionScreenProvider.noteController,
                        onChanged: (String newVal) => writeActionScreenProvider
                            .checkTextFieldUpdate(newVal, 'note'),
                        hintText:
                            AppLocalizations.of(context).translate('note'),
                        textStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  StyleList.verticalBox20,
                  Container(
                    height: 96,
                    padding: StyleList.horizontalPadding20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SubmitButtonWrapper(),
                        //* for snackbar
                        Builder(builder: (context) {
                          return FlatButton(
                            onPressed: isNew
                                ? null
                                : () async => await _onPressedDelete(context,
                                    appProvider, currentActionWithTags),
                            child: Text(
                              isNew
                                  ? ''
                                  : AppLocalizations.of(context)
                                      .translate('delete'),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 20.0,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
