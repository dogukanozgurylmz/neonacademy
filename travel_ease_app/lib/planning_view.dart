import 'package:flutter/material.dart';
import 'package:travel_ease_app/models/holiday_model.dart';

class PlanningView extends StatelessWidget {
  final List<HolidayModel> holidays;
  const PlanningView({super.key, required this.holidays});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: holidays.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text(
                holidays[index].city,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              backgroundColor: Colors.black54,
              side: const BorderSide(width: 0, color: Colors.transparent),
            ),
          );
        },
      ),
    );
  }
}
