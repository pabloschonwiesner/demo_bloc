import 'package:demo_provider/ui/core/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:demo_provider/ui/core/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo State Managment',
      theme: AppTheme.lightTheme,
      initialRoute: 'home',
      routes: routes,
      // supportedLocales: const [
      //   Locale('en', null),
      //   Locale('es', null),
      // ],
    );
  }
}