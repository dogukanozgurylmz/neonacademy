import 'package:flutter/material.dart';

class CustomScrollsView extends StatefulWidget {
  const CustomScrollsView({Key? key}) : super(key: key);

  @override
  State<CustomScrollsView> createState() => _CustomScrollsViewState();
}

class _CustomScrollsViewState extends State<CustomScrollsView> {
  List<String> data = [
    'Veri 1',
    'Veri 2',
    'Veri 3',
    'Veri 4',
  ];

  ScrollController _scrollController = ScrollController();
  bool isEndOfList = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isEndOfList = true;
      });
    }
  }

  void loadMoreData() {
    if (data.length >= 8) return;
    List<String> newItems = ['Veri 5', 'Veri 6', 'Veri 7', 'Veri 8'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        data.addAll(newItems);
        isEndOfList = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollview Page'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: data.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == data.length) {
            if (isEndOfList) {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: Text(
                    'Sayfanın sonu',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            } else {
              loadMoreData();
              return const CircularProgressIndicator();
            }
          } else {
            return Padding(
              padding: const EdgeInsets.all(72.0),
              child: ListTile(
                title: Text(data[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
