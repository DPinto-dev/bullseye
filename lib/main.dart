import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Bullseye',
      home: GamePage(),
    ),
  );
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hello from BullsEye APP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green),
            ),
            TextButton(
              onPressed: () {
                _showAlert(context);
              },
              child: const Text('Tap me here!',
                  style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          print('Dismiss pressed!');
        },
        child: const Text('Dismiss'));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hello there!'),
            content: const Text('This is my first popup!'),
            actions: [okButton],
            elevation: 5,
          );
        });
  }
}
