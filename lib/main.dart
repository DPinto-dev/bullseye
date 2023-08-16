import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'prompt.dart';
import 'control.dart';
import 'score.dart';
import 'game_model.dart';

void main() {
  runApp(const BullsEyeApp());
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return const MaterialApp(
      title: 'Bullseye',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('images/background.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Prompt(targetValue: _model.target),
              Control(model: _model),
              TextButton(
                onPressed: () {
                  _showAlert(context);
                },
                child:
                    const Text('HIT ME!', style: TextStyle(color: Colors.blue)),
              ),
              Score(
                totalScore: _model.totalScore,
                round: _model.round,
                onStartOver: _startNewGame,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _pointsForCurrentRound() {
    const maximumScore = 100;
    var pointsDifference = _differenceAmount();
    return maximumScore - pointsDifference + _bonusPoints();
  }

  String _alertTitle() {
    String title;
    var pointsDifference = _differenceAmount();
    if (pointsDifference == 0) {
      title = 'Perfect! Extra 100 points!';
    } else if (pointsDifference == 1) {
      title = 'You almost had it! Extra 50 points!';
    } else if (pointsDifference < 5) {
      title = 'You almost had it!';
    } else if (pointsDifference <= 10) {
      title = 'Not bad.';
    } else {
      title = 'Are you even trying?';
    }
    return title;
  }

  int _differenceAmount() => (_model.current - _model.target).abs();

  int _bonusPoints() {
    var pointsDifference = _differenceAmount();
    if (pointsDifference == 0) {
      return 100;
    } else if (pointsDifference == 1) {
      return 50;
    }
    return 0;
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.scoreStart;
      _model.round = GameModel.roundStart;
      _model.current = GameModel.sliderStart;
      _model.target = _newTargetValue();
    });
  }

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = _newTargetValue();
            _model.round++;
          });
        },
        child: const Text('Dismiss'));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_alertTitle()),
            content: Text('The slider\'s value is ${_model.current}.\n'
                'You scored ${_pointsForCurrentRound()} points this round.'),
            actions: [okButton],
            elevation: 5,
          );
        });
  }
}
