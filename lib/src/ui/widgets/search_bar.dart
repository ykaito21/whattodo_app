import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../../app_localizations.dart';
import '../../core/providers/actions_screen_provider.dart';
import '../global/style_list.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActionsScreenProvider actionsScreenProvider =
        Provider.of<ActionsScreenProvider>(context, listen: false);
    return TextField(
      onChanged: actionsScreenProvider.searchInput,
      controller: actionsScreenProvider.searchController,
      decoration: InputDecoration(
        contentPadding: StyleList.horizontalPadding20,
        // hintText: AppLocalizations.of(context).translate('searchHint'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        suffixIcon: actionsScreenProvider.toggleIcon()
            ? Icon(
                Icons.search,
              )
            : IconButton(
                onPressed: actionsScreenProvider.clearKeywords,
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).accentColor,
                ),
              ),
      ),
    );
  }
}
