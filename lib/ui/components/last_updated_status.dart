import 'package:flutter/material.dart';

class LastUpdatedStatus extends StatelessWidget {
  const LastUpdatedStatus({Key key, @required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
