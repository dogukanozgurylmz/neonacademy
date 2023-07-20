import 'package:flutter/material.dart';

class ItemModel {
  final String id;
  final String title;
  final String image;

  ItemModel({required this.id, required this.title, required this.image});
}

class HeroView extends StatelessWidget {
  final List<ItemModel> items = [
    ItemModel(id: '1', title: 'Item 1', image: 'https://picsum.photos/1000'),
    ItemModel(id: '2', title: 'Item 2', image: 'https://picsum.photos/1200'),
    ItemModel(id: '3', title: 'Item 3', image: 'https://picsum.photos/1300'),
    ItemModel(id: '4', title: 'Item 4', image: 'https://picsum.photos/1400'),
    // Ekleme yapılabilir
  ];

  HeroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Özellikleri')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetailPage(item: item);
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Yönlere göre animasyonlar belirleyelim
                    if (index == 0) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: const Offset(0, 1), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      );
                    } else if (index == 1) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: const Offset(-1, 0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      );
                    } else if (index == 2) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: const Offset(0, -1), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      );
                    } else if (index == 3) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(begin: const Offset(1, 0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      );
                    } else {
                      // Farklı durumlar için varsayılan bir animasyon yolu belirleyelim
                      return child;
                    }
                  },
                ),
              );
            },
            child: Hero(
              tag: item.id, // Her öğe için benzersiz bir etiket belirlemeliyiz
              child: Image.network(
                item.image,
                fit: BoxFit
                    .cover, // Fotoğrafların boyutlandırılması için BoxFit kullanalım
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final ItemModel item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detay')),
      body: Center(
        child: Hero(
          tag: item.id, // Ana sayfada kullanılan etiketle aynı olmalıdır
          child: Image.network(
            item.image,
            fit: BoxFit
                .cover, // Fotoğrafların boyutlandırılması için BoxFit kullanalım
          ),
        ),
      ),
    );
  }
}
