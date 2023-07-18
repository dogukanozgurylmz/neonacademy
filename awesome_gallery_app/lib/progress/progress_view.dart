import 'dart:math';

import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  int value = 0;
  bool _isCancelled = false;
  Color currentColor = Colors.white;
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.brown,
    Colors.blueAccent,
    Colors.amber,
    Colors.cyan,
    Colors.deepOrangeAccent,
    Colors.orange,
  ];

  Future<void> progress() async {
    for (var i = 0; i <= 100; i++) {
      if (_isCancelled) return;
      if (i % 10 == 0) {
        Random rand = Random();
        var nextInt = rand.nextInt(10);
        setState(() {
          currentColor = colors[nextInt];
        });
      }
      setState(() {
        value = i;
      });
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  @override
  void initState() {
    super.initState();
    progress();
  }

  @override
  void dispose() {
    _isCancelled = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      appBar: AppBar(
        title: const Text("Progress"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          value == 100
              ? const SizedBox.shrink()
              : const CircularProgressIndicator(),
          value == 100 ? const SizedBox.shrink() : Text(value.toString()),
        ],
      )),
    );
  }
}
