import 'package:covid19tracker/app/services/api.dart';
import 'package:covid19tracker/app/services/endpoint_data.dart';
import 'package:covid19tracker/repositories/endpoints_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endpointValueKey(EndPoint endpoint) => '$endpoint/value';
  static String endpointDateKey(EndPoint endpoint) => '$endpoint/date';

  Future<void> setData(EndPointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(
        endpointValueKey(endpoint),
        endpointData.value,
      );
      await sharedPreferences.setString(
        endpointDateKey(endpoint),
        endpointData.date.toIso8601String(),
      );
    });
  }

  EndPointsData getData() {
    Map<EndPoint, EndPointData> values = {};

    EndPoint.values.forEach((endpoint) {
      final value = sharedPreferences.get(endpointValueKey(endpoint));
      final dateString = sharedPreferences.get(endpointDateKey(endpoint));
      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndPointData(value: value, date: date);
      }
    });
    return EndPointsData(values: values);
  }
}
