import 'package:covid19tracker/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndPointCardData {
  EndPointCardData(this.title, this.assetName, this.color);

  final String title;
  final String assetName;
  final Color color;
}

class EndPointCard extends StatelessWidget {
  const EndPointCard({Key key, this.endpoint, this.value}) : super(key: key);

  final EndPoint endpoint;
  final int value;

  static Map<EndPoint, EndPointCardData> _cardsData = {
    EndPoint.cases:
        EndPointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    EndPoint.casesSuspected: EndPointCardData(
        'Suspected cases', 'assets/suspect.png', Color(0xFFEEDA28)),
    EndPoint.casesConfirmed: EndPointCardData(
        'Confirmed cases', 'assets/fever.png', Color(0xFFE99600)),
    EndPoint.deaths:
        EndPointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    EndPoint.recovered:
        EndPointCardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  String get formattedValue {
    if (value == null) {
      return '11111111111111111';
    }
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: cardData.color),
              ),
              SizedBox(height: 4),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: cardData.color, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
