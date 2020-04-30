import 'package:covid19tracker/ui/themesettings/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/services/api.dart';
import 'app/services/api_service.dart';
import 'app/services/data_cache_service.dart';
import 'repositories/data_repository.dart';
import 'ui/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
        Provider(
          create: (context) => DataRepository(
            apiService: APIService(API.sandbox()),
            dataCacheService:
                DataCacheService(sharedPreferences: sharedPreferences),
          ),
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
