import 'package:covid19tracker/app/services/api.dart';
import 'package:covid19tracker/repositories/data_repository.dart';
import 'package:covid19tracker/ui/components/endpint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cases;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(EndPoint.cases);
    setState(() => _cases = cases);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid19 Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //Navigate to Settings screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          EndPointCard(endpoint: EndPoint.cases, value: _cases),
        ],
      ),
    );
  }
}
