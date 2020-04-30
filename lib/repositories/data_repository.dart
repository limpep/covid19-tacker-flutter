import 'package:covid19tracker/app/services/api.dart';
import 'package:covid19tracker/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'endpoints_data.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;
  String _accessToken;

  Future<int> getEndpointData(EndPoint endpoint) async =>
      await _getDataRefreshingToken<int>(
          onGetData: () => apiService.getEndpointData(
              accessToken: _accessToken, endpoint: endpoint));

//  Future<EndPointData> getAllEndpointData() async {
//    try {
//      if (_accessToken == null) {
//        _accessToken = await apiService.getAccessToken();
//      }
//      return await _getAllEndpointsData();
//    } on Response catch (response) {
//      if (response.statusCode == 401) {
//        _accessToken = await apiService.getAccessToken();
//        return await _getAllEndpointsData();
//      }
//      rethrow;
//    }
//  }

  Future<EndPointData> getAllEndpointData() async =>
      await _getDataRefreshingToken<EndPointData>(
          onGetData: _getAllEndpointsData);

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndPointData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: EndPoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: EndPoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: EndPoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: EndPoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: EndPoint.recovered),
    ]);

    return EndPointData(values: {
      EndPoint.cases: values[0],
      EndPoint.casesSuspected: values[1],
      EndPoint.casesConfirmed: values[2],
      EndPoint.deaths: values[3],
      EndPoint.recovered: values[4],
    });
  }
}
