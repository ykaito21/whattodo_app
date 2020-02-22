import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'core/providers/app_provider.dart';
import 'ui/global/app_theme.dart';
import 'ui/global/routes/route_generator.dart';
// import 'ui/screens/home_screen.dart';

class App extends StatelessWidget {
  //todo check English
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AppProvider(),
          dispose: (_, appProvider) => appProvider.dispose,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'What2Do',
        theme: appThemes[AppTheme.Light],
        darkTheme: appThemes[AppTheme.Dark],
        // home: HomeScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ja', 'JP'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FallbackCupertinoLocalisationsDelegate()
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
