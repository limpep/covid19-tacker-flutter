import 'package:covid19tracker/app/services/api.dart';
import 'package:flutter/foundation.dart';

class EndPointData {
  EndPointData({@required this.values});
  final Map<EndPoint, int> values;

  int get cases => values[EndPoint.cases];
  int get casesSuspected => values[EndPoint.casesSuspected];
  int get casesConfirmed => values[EndPoint.casesConfirmed];
  int get deaths => values[EndPoint.deaths];
  int get recovered => values[EndPoint.recovered];

  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
