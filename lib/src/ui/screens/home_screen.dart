import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global/routes/route_generator.dart';
import 'actions_screen_wrapper.dart';
import 'slot_screen_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigators = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    //? need scaffold?
    return WillPopScope(
      onWillPop: () async =>
          !await _navigators[_currentIndex].currentState.maybePop(),
      child: CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: _navigators[index],
            onGenerateRoute: RouteGenerator.generateRoute,
            builder: (context) {
              switch (index) {
                case 0:
                  return SlotScreenWrapper();
                case 1:
                  return ActionsScreenWrapper();
                default:
                  return Container();
              }
            },
          );
        },
        tabBar: CupertinoTabBar(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.0, // One physical pixel.
              style: BorderStyle.solid,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          activeColor: Theme.of(context).accentColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              // title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
            ),
          ],
          onTap: (index) {
            if (_currentIndex == index) {
              _navigators[index]
                  .currentState
                  .popUntil((route) => route.isFirst);
            }
            //? need setState?
            _currentIndex = index;
          },
        ),
      ),
    );
  }
}
