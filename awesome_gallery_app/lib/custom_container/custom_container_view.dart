import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomContainerView extends StatefulWidget {
  const CustomContainerView({super.key});

  @override
  State<CustomContainerView> createState() => _CustomContainerViewState();
}

class _CustomContainerViewState extends State<CustomContainerView> {
  List<Map<String, dynamic>> list = [
    {
      "title": "Home",
      "color": Colors.amber.shade100,
      "icon": const Icon(Icons.home),
      "status": false,
    },
    {
      "title": "AC",
      "color": Colors.blue.shade100,
      "icon": const Icon(Icons.ac_unit),
      "status": false,
    },
    {
      "title": "Alarm",
      "color": Colors.brown.shade100,
      "icon": const Icon(Icons.access_alarm),
      "status": false,
    },
    {
      "title": "Time",
      "color": Colors.cyan.shade100,
      "icon": const Icon(Icons.access_time_outlined),
      "status": false,
    },
    {
      "title": "Accessibility",
      "color": Colors.deepOrange.shade100,
      "icon": const Icon(Icons.accessibility),
      "status": false,
    },
    {
      "title": "Balance",
      "color": Colors.deepPurple.shade100,
      "icon": const Icon(Icons.account_balance),
      "status": false,
    },
    {
      "title": "Account",
      "color": Colors.green.shade100,
      "icon": const Icon(Icons.account_circle_outlined),
      "status": false,
    },
    {
      "title": "Add",
      "color": Colors.indigo.shade100,
      "icon": const Icon(Icons.add),
      "status": false,
    },
    {
      "title": "adb",
      "color": Colors.lightBlue.shade100,
      "icon": const Icon(Icons.adb),
      "status": true,
    },
    {
      "title": "Add Photo",
      "color": Colors.lime.shade100,
      "icon": const Icon(Icons.add_a_photo),
      "status": false,
    },
    {
      "title": "Add Card",
      "color": Colors.pink.shade100,
      "icon": const Icon(Icons.add_card),
      "status": true,
    },
  ];
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Awesome Gallery"),
      ),
      body: GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            const QuiltedGridTile(2, 2),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: list.length,
          (context, index) {
            if (index % 4 == 1) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      list[index]["color"],
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    list[index]["icon"],
                    Text(list[index]["title"]),
                  ],
                ),
              );
            } else if (index % 4 == 3) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: list[index]["color"],
                      blurRadius: 50,
                      spreadRadius: 0,
                    ),
                  ],
                  color: list[index]["color"],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    list[index]["icon"],
                    Text(list[index]["title"]),
                  ],
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: list[index]["color"],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  list[index]["icon"],
                  Text(list[index]["title"]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
