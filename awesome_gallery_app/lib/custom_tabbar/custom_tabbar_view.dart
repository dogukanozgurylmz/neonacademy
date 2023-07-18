import 'package:flutter/material.dart';

class CustomTabbarView extends StatefulWidget {
  const CustomTabbarView({super.key});

  @override
  State<CustomTabbarView> createState() => _CustomTabbarViewState();
}

class _CustomTabbarViewState extends State<CustomTabbarView>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT', icon: Icon(Icons.first_page)),
    Tab(text: 'RIGHT', icon: Icon(Icons.last_page)),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tabbar"),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: myTabs,
            dividerColor: Colors.green,
            labelColor: Colors.green,
            overlayColor: const MaterialStatePropertyAll(Colors.greenAccent),
            indicatorColor: Colors.greenAccent,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(-4),
            indicatorWeight: 8,
            splashBorderRadius: BorderRadius.circular(80),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                final String label = tab.text!;
                return Center(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 36),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
