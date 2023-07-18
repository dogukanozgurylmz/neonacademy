import 'package:flutter/material.dart';

class Article {
  final String title;
  final String imageUrl;
  final String description;

  Article(
      {required this.title, required this.imageUrl, required this.description});
}

class CustomListViewPage extends StatelessWidget {
  final List<Article> articles = List.generate(
    90,
    (index) => Article(
      title: 'Headline ${index + 1}',
      imageUrl: "",
      description: 'This is the description of headline 1.',
    ),
  );

  // Article(
  //   title: 'Headline 2',
  //   imageUrl: "",
  //   description: 'This is the description of headline 2.',
  // ),
  // Article(
  //   title: 'Headline 3',
  //   imageUrl: "",
  //   description: 'This is the description of headline 3.',
  // ),

  CustomListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News Screen'),
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];

            return ListTile(
              leading: article.imageUrl == ""
                  ? const FlutterLogo()
                  : Image.network(
                      article.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
              title: Text(article.title),
              subtitle: Text(article.description),
            );
          },
        ));
  }
}
