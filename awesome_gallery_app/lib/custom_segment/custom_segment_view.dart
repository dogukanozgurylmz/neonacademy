import 'package:flutter/material.dart';

class CustomSegmentView extends StatefulWidget {
  const CustomSegmentView({super.key});

  @override
  State<CustomSegmentView> createState() => _CustomSegmentViewState();
}

class _CustomSegmentViewState extends State<CustomSegmentView> {
  String selected = "Neon Academy 2023";
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
                setState(() {
                  selected = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
