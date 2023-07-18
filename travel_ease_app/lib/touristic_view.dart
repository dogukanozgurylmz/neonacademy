// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:travel_ease_app/models/touristic_model.dart';

import 'touristic_detail_view.dart';

class TouristicView extends StatefulWidget {
  List<TouristicModel> touristics;
  TouristicView({
    Key? key,
    required this.touristics,
  }) : super(key: key);

  @override
  State<TouristicView> createState() => _TouristicViewState();
}

class _TouristicViewState extends State<TouristicView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.touristics.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TouristicDetailView(model: widget.touristics[index]),
              ));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Placeholder(fallbackHeight: 100),
                  Text(widget.touristics[index].name),
                  Text(widget.touristics[index].address),
                  Text(
                    widget.touristics[index].description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
