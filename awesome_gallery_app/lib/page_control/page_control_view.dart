import 'package:flutter/material.dart';

class PageControlView extends StatefulWidget {
  const PageControlView({super.key});

  @override
  State<PageControlView> createState() => _PageControlViewState();
}

class _PageControlViewState extends State<PageControlView> {
  PageController _pageController = PageController();

  List<String> titles = [
    "Sayfa 1 Başlık",
    "Sayfa 2 Başlık",
    "Sayfa 3 Başlık",
  ];

  List<String> subtitles = [
    "Sayfa 1 Alt Başlık",
    "Sayfa 2 Alt Başlık",
    "Sayfa 3 Alt Başlık",
  ];

  List<String> images = [
    "https://picsum.photos/1000/1000",
    "https://picsum.photos/1100/1100",
    "https://picsum.photos/1200/1200",
  ];

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sayfa Kontrolü"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return PageView.builder(
                  itemCount: colors.length,
                  itemBuilder: (context, index2) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images[index]),
                          fit: BoxFit.fitWidth,
                        ),
                        color: colors[index2],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titles[index],
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitles[index],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
