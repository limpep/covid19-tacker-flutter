import 'package:covid19tracker/ui/themesettings/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/services/api.dart';
import 'app/services/api_service.dart';
import 'repositories/data_repository.dart';
import 'ui/screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
        Provider(
          create: (context) =>
              DataRepository(apiService: APIService(API.sandbox())),
        )
      ],
      child: Consumer<ThemeManager>(
        builder: (context, manager, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Covid 19 Tracker',
          theme: manager.themeData,
          home: Dashboard(),
        ),
      ),
    );
  }
}
