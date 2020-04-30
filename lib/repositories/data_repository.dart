import 'package:covid19tracker/app/services/api.dart';
import 'package:covid19tracker/app/services/api_service.dart';
import 'package:covid19tracker/app/services/data_cache_service.dart';
import 'package:covid19tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'endpoints_data.dart';

class DataRepository {
  DataRepository({@required this.apiService, @required this.dataCacheService});
  final APIService apiService;
  final DataCacheService dataCacheService;

  String _accessToken;

  Future<EndPointData> getEndpointData(EndPoint endpoint) async =>
      await _getDataRefreshingToken<EndPointData>(
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

  EndPointsData getAllEndpointsCachedData() => dataCacheService.getData();

  Future<EndPointsData> getAllEndpointData() async {
    final endpointsData = await _getDataRefreshingToken<EndPointsData>(
        onGetData: _getAllEndpointsData);

    await dataCacheService.setData(endpointsData);

    return endpointsData;
  }

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

  Future<EndPointsData> _getAllEndpointsData() async {
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

    return EndPointsData(values: {
      EndPoint.cases: values[0],
      EndPoint.casesSuspected: values[1],
      EndPoint.casesConfirmed: values[2],
      EndPoint.deaths: values[3],
      EndPoint.recovered: values[4],
    });
  }
}
