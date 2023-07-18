// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travel_ease_app/models/touristic_model.dart';

class TouristicDetailView extends StatelessWidget {
  final TouristicModel model;
  const TouristicDetailView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Placeholder(fallbackHeight: 200),
            const SizedBox(height: 8),
            Text(model.address),
            const SizedBox(height: 8),
            Text(model.description),
          ],
        ),
      ),
    );
  }
}
