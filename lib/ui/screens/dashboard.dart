import 'dart:io';

import 'package:covid19tracker/app/services/api.dart';
import 'package:covid19tracker/repositories/data_repository.dart';
import 'package:covid19tracker/repositories/endpoints_data.dart';
import 'package:covid19tracker/ui/components/endpint_card.dart';
import 'package:covid19tracker/ui/components/last_updated_status.dart';
import 'package:covid19tracker/ui/components/show_alert_dialog.dart';
import 'package:covid19tracker/utils/last_updated_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'settings.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndPointsData _endpointsData;

  @override
  void initState() {
    super.initState();

    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
//      final cases = await dataRepository.getEndpointData(EndPoint.cases);
      final endpointData = await dataRepository.getAllEndpointData();
      setState(() => _endpointsData = endpointData);
    } on SocketException catch (e) {
      debugPrint(e.toString());
      await showAlertDialog(
          context: context,
          title: 'Connection error',
          content: 'Could not retrieve data. Please try again later.',
          defaultActionText: 'OK');
    } catch (e) {
      debugPrint(e.toString());
      await showAlertDialog(
          context: context,
          title: 'Unknown error',
          content: 'Server returned an unknown error.',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData.values[EndPoint.cases]?.date ?? DateTime.now()
            : null);
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
      body: LiquidPullToRefresh(
        onRefresh: _updateData,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 600,
        backgroundColor: Theme.of(context).canvasColor,
        child: ListView(
          children: <Widget>[
            LastUpdatedStatus(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in EndPoint.values)
              EndPointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
