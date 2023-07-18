import 'package:flutter/material.dart';

class LinearProgressView extends StatefulWidget {
  const LinearProgressView({super.key});

  @override
  State<LinearProgressView> createState() => _LinearProgressStateView();
}

class _LinearProgressStateView extends State<LinearProgressView> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linear Progress"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: value / 10),
            TextButton(
              onPressed: () {
                setState(() {
                  value = value + 1;
                  if (value == 10) {
                    value = 0;
                  }
                });
              },
              child: const Text("İlerle"),
            ),
          ],
        ),
      ),
    );
  }
}
