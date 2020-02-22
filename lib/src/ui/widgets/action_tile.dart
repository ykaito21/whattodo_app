import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/routes/route_path.dart';
import '../global/style_list.dart';
import '../shared/platform/platform_alert_dialog.dart';

class ActionTile extends StatelessWidget {
  final ActionWithTags actionWithTags;

  const ActionTile({
    Key key,
    @required this.actionWithTags,
  })  : assert(actionWithTags != null),
        super(key: key);

  String get actionName => actionWithTags.action.name;
  List<Tag> get tags => actionWithTags.tags;

  Future<bool> _onWillDismiss(context, String actionName) {
    return PlatformAlertDialog(
      title: StyleList.localizedAlertTtile(context, actionName),
      content:
          '${AppLocalizations.of(context).translate('alertDeleteContentAction')}',
      defaultActionText: AppLocalizations.of(context).translate('delete'),
      cancelActionText: AppLocalizations.of(context).translate('cancel'),
    ).show(context);
  }

  void _onDismissed(BuildContext context, AppProvider appProvider) {
    appProvider.deleteActionWithTags(actionWithTags);
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        StyleList.baseSnackBar(context,
            '"$actionName" ${AppLocalizations.of(context).translate('wasDeleted')}'),
      );
  }

  Future<void> _onTapDelete(
      BuildContext context, AppProvider appProvider) async {
    FocusScope.of(context).unfocus();
    final bool res = await _onWillDismiss(context, actionName);
    if (res) {
      _onDismissed(context, appProvider);
    }
  }

  void _onTapEdit(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.of(context, rootNavigator: true)
        .pushNamed(RoutePath.writeActionScreen, arguments: actionWithTags);
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final Color appliedSlidableColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white;
    return Slidable(
      //* to work with SlidableDismissal and CupertinoTabView
      key: ValueKey(actionWithTags.action),
      dismissal: SlidableDismissal(
        onWillDismiss: (actionType) => _onWillDismiss(context, actionName),
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) => _onDismissed(context, appProvider),
      ),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        onTap: () => _onTapEdit(context),
        contentPadding: StyleList.horizontalPadding20,
        title: Text(
          actionName,
          style: StyleList.baseTitleTextStyle,
        ),
        subtitle: Wrap(children: _tags(context, tags, appliedSlidableColor)),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          onTap: () => _onTapEdit(context),
          color: Theme.of(context).accentColor,
          foregroundColor: appliedSlidableColor,
          icon: Icons.edit,
          caption: AppLocalizations.of(context).translate('edit'),
        ),
        IconSlideAction(
          onTap: () async => await _onTapDelete(context, appProvider),
          color: Theme.of(context).accentColor,
          foregroundColor: appliedSlidableColor,
          icon: Icons.delete,
          caption: AppLocalizations.of(context).translate('delete'),
        ),
      ],
    );
  }

  List<Widget> _tags(
      BuildContext context, List<Tag> tags, Color appliedSlidableColor) {
    return <Widget>[
      ...tags.map(
        (tag) => Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            padding: StyleList.verticalHorizontalPaddding25,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              tag.name,
              style: TextStyle(
                color: appliedSlidableColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    ];
  }
}
