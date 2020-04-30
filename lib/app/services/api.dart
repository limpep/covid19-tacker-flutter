import 'package:covid19tracker/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum EndPoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = "apigw.nubentos.com";
  static final int port = 443;
  static final String basePath = "t/nubentos.com/ncovapi/1.0.0";

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(EndPoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: '$basePath/${_paths[endpoint]}',
      );

  static Map<EndPoint, String> _paths = {
    EndPoint.cases: 'cases',
    EndPoint.casesSuspected: 'cases/suspected',
    EndPoint.casesConfirmed: 'cases/confirmed',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered',
  };
}
