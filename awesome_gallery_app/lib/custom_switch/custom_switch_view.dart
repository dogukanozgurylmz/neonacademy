import 'package:flutter/material.dart';

class CustomSwitchView extends StatefulWidget {
  const CustomSwitchView({super.key});

  @override
  State<CustomSwitchView> createState() => _CustomSwitchViewState();
}

class _CustomSwitchViewState extends State<CustomSwitchView> {
  Color bgColor = Colors.green;
  Color switchColor = Colors.red;
  bool val = false;

  void changeBGColor() {
    if (val) {
      bgColor = Colors.red;
    } else {
      bgColor = Colors.green;
    }
  }

  void changeSwitchColor() {
    if (val) {
      switchColor = Colors.green;
    } else {
      switchColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Switch"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: val,
              thumbColor: MaterialStateProperty.all(Colors.black),
              trackColor: MaterialStateProperty.all(switchColor),
              onChanged: (value) {
                setState(() {
                  val = value;
                  changeBGColor();
                  changeSwitchColor();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
