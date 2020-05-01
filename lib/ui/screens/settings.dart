import 'package:covid19tracker/ui/themesettings/app_theme.dart';
import 'package:covid19tracker/ui/themesettings/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Theme select',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AppTheme.values.length,
                itemBuilder: (BuildContext context, int index) {
                  // Get theme enum for the current item index
                  final theme = AppTheme.values[index];
                  return Card(
                    // Style the item with corresponding theme color
                    color: appThemeData[theme].primaryColor,
                    child: ListTile(
                      onTap: () {
                        // This will trigger notifyListeners and rebuild UI
                        // because of ChangeNotifierProvider in ThemeApp
                        Provider.of<ThemeManager>(context, listen: false)
                            .setTheme(theme);
                      },
                      title: Text(
                        enumName(theme),
                        style: appThemeData[theme].textTheme.body1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
