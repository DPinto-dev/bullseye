import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({super.key, required this.totalScore, required this.round});

  final int totalScore;
  final int round;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(onPressed: () {}, child: const Text('Start Over')),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text('Score: '),
              Text('100'),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Round: '),
              Text('1'),
            ],
          ),
        ),
        TextButton(onPressed: () {}, child: const Text('Info'))
      ],
    );
  }
}
