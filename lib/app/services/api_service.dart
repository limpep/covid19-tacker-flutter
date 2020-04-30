import 'dart:convert';
import 'package:covid19tracker/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'endpoint_data.dart';

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    throw response;
  }

  Future<EndPointData> getEndpointData(
      {@required String accessToken, @required EndPoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJson = _responseJsonKey[endpoint];
        final int value = endpointData[responseJson];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);

        if (value != null) {
          return EndPointData(value: value, date: date);
        }
      }
    }
    debugPrint(
        'Request $uri failed \n Response: ${response.statusCode} ${response.reasonPhrase}');

    throw response;
  }

  static Map<EndPoint, String> _responseJsonKey = {
    EndPoint.cases: 'cases',
    EndPoint.casesSuspected: 'data',
    EndPoint.casesConfirmed: 'data',
    EndPoint.deaths: 'data',
    EndPoint.recovered: 'data',
  };
}
