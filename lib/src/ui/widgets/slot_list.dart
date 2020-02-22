import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/services/database_service.dart';

class SlotList extends StatelessWidget {
  final List<ActionWithTags> actionWithTagsList;
  const SlotList({
    Key key,
    @required this.actionWithTagsList,
  })  : assert(actionWithTagsList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlotScreenProvider slotScreenProvider =
        Provider.of<SlotScreenProvider>(context, listen: false);
    return ListWheelScrollView.useDelegate(
      controller: slotScreenProvider.slotScrollController,
      physics: FixedExtentScrollPhysics(),
      itemExtent: 100.0,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: actionWithTagsList.isEmpty
            ? _emptyList(context)
            : _actionList(context, actionWithTagsList),
      ),
    );
  }

  List<Widget> _emptyList(context) {
    return <Widget>[
      Container(
        child: Center(
          child: AutoSizeText(
            AppLocalizations.of(context).translate('slotEmpty'),
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 48.0,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
            minFontSize: 24,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  List<Widget> _actionList(
      BuildContext context, List<ActionWithTags> actionWithTagsList) {
    return <Widget>[
      ...actionWithTagsList.map(
        (ActionWithTags actionWithTags) {
          return Container(
            child: Center(
              child: AutoSizeText(
                actionWithTags.action.name,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 48.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
                minFontSize: 24,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      )
    ];
  }
}
