import 'package:flutter/material.dart';

class CustomSliderView extends StatefulWidget {
  const CustomSliderView({super.key});

  @override
  State<CustomSliderView> createState() => _CustomSliderViewState();
}

class _CustomSliderViewState extends State<CustomSliderView> {
  double val = 0.5;
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: Slider(
                value: val,
                onChanged: (value) {
                  setState(() {
                    val = value;
                    if (value == 1) {
                      color = Colors.red;
                    } else if (value == 0) {
                      color = Colors.green;
                    } else {
                      color = Color.lerp(Colors.green, Colors.red, value)!;
                    }
                  });
                },
                divisions: 10,
                activeColor: color,
                thumbColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
