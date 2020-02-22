import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import '../../app_localizations.dart';
import '../../core/services/database_service.dart' as db;
import '../global/style_list.dart';
import '../shared/platform/platform_alert_dialog.dart';

class TagList extends StatelessWidget {
  final List<db.Tag> tags;
  final provider;
  final bool editable;
  final List<db.Tag> selectedTags;

  TagList({
    Key key,
    @required this.tags,
    @required this.provider,
    this.editable = false,
    this.selectedTags = const [],
  })  : assert(tags != null),
        assert(provider != null),
        super(key: key);

  void _onLongPressed(BuildContext context, db.Tag tag) async {
    final bool res = await PlatformAlertDialog(
      title: StyleList.localizedAlertTtile(context, tag.name),
      content:
          '${AppLocalizations.of(context).translate('alertDeleteContentTag')}',
      defaultActionText: AppLocalizations.of(context).translate('delete'),
      cancelActionText: AppLocalizations.of(context).translate('cancel'),
    ).show(context);
    if (res) {
      await provider.onRemoveTag(tag);
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          StyleList.baseSnackBar(context,
              '"${tag.name}" ${AppLocalizations.of(context).translate('wasDeleted')}'),
        );
      //! bug cannot add the same tag if deleted it at the same screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      itemCount: tags.length,
      textField: _tagsTextField(context),
      itemBuilder: (int index) {
        final db.Tag tag = tags[index];
        final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return ItemTags(
          onPressed: (item) =>
              provider.onPressedTag(item.customData, item.active),
          key: UniqueKey(),
          index: index,
          title: tag.name,
          active: selectedTags.contains(tag) ? true : false,
          customData: tag,
          elevation: 2,
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(color: Theme.of(context).accentColor),
          color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
          activeColor: Theme.of(context).accentColor,
          textColor: isDarkMode ? Colors.white : Colors.black,
          textActiveColor: isDarkMode ? Colors.black : Colors.white,
          textStyle: TextStyle(
            fontSize: 16,
          ),
          removeButton: editable
              ? ItemTagsRemoveButton(
                  backgroundColor:
                      isDarkMode ? Colors.grey[700] : Colors.grey[200],
                  color: Theme.of(context).accentColor,
                )
              : null,
          // onRemoved: () async {
          //   await provider.onRemoveTag(tag, context);
          // },
          onLongPressed: editable
              ? (item) async => _onLongPressed(context, item.customData)
              : null,
        );
      },
    );
  }

  TagsTextField _tagsTextField(BuildContext context) {
    return editable
        ? TagsTextField(
            onSubmitted: provider.onSubmitTag,
            autofocus: false,
            hintText: AppLocalizations.of(context).translate('newTag'),
            helperText: ' ',
            width: 80.0,
            maxLength: 10,
            textStyle: TextStyle(
              fontSize: 16.0,
            ),
            inputDecoration: InputDecoration(
              counterText: '',
              //* to remove bottom padding
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          )
        : null;
  }
}
