import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              shadowColor: const Color.fromARGB(255, 67, 89, 200),
              title: const Text("My App")),
          body: Stack(children: [
            Container(
              color: Colors.amber,
              width: 100,
              height: 100,
            ),
            const Icon(Icons.access_alarm),
            const Icon(Icons.tab),
            const Icon(Icons.leaderboard),
            const Icon(Icons.person),
            const Text('Hi from the body 👋🏻👋🏻👋🏻'),
            Text('$count')
          ])),
    );
  }
}
