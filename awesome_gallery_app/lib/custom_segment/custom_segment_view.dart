// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:flutter/material.dart';

class CustomSegmentView extends StatefulWidget {
  const CustomSegmentView({super.key});

  @override
  State<CustomSegmentView> createState() => _CustomSegmentViewState();
}

class _CustomSegmentViewState extends State<CustomSegmentView> {
  String selected = "Neon Academy 2023";
  double selectedHeight = 400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segment Control"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton(
              emptySelectionAllowed: true,
              segments: const [
                ButtonSegment(
                  value: "Neon Academy 2023",
                  label: Text("Neon Academy 2023"),
                ),
                ButtonSegment(
                  value: "Neon",
                  label: Text("Neon"),
                ),
                ButtonSegment(
                  value: "Apps",
                  label: Text("Apps"),
                ),
              ],
              selected: <String>{selected},
              onSelectionChanged: (Set<String> newSelection) {
                switch (newSelection.first) {
                  case "Neon Academy 2023":
                    setState(() {
                      selectedHeight = 400;
                    });
                  case "Neon":
                    setState(() {
                      selectedHeight = 200;
                    });
                  case "Apps":
                    setState(() {
                      selectedHeight = 100;
                    });
                  default:
                }
                setState(() {
                  selected = newSelection.first;
                });
              },
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: selectedHeight,
              color: Colors.blue,
              child: Text(selected),
            ),
          ],
        ),
      ),
    );
  }
}
