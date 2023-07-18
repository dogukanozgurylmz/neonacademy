import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class CustomGridViewPage extends StatefulWidget {
  const CustomGridViewPage({super.key});

  @override
  State<CustomGridViewPage> createState() => _CustomGridViewPageState();
}

class _CustomGridViewPageState extends State<CustomGridViewPage> {
  final List<App> apps = [];
  bool isLoad = false;

  Future<void> fetchApp() async {
    apps.clear();
    setState(() {
      isLoad = true;
    });
    final response =
        await http.get(Uri.parse('https://www.neonapps.co/referance-apps'));
    final document = parser.parse(response.body);

    final appElements = document.getElementsByClassName('Zc7IjY');

    for (final appElement in appElements) {
      final nameElement = appElement.querySelector('.wixui-rich-text__text');
      final contentElement =
          appElement.querySelector('.comp-l9oacn74 .wixui-rich-text__text');
      final imageElement = appElement.querySelector('.comp-l9oa6r9l img');
      final categoryElement =
          appElement.querySelector('.comp-l9oa9862 .wixui-rich-text__text');

      final appName = nameElement?.text.trim();
      final appContent = contentElement?.text.trim();
      final appImage = imageElement?.attributes['src'];
      final appCategory = categoryElement?.text.trim();

      var app = App(
        appName: appName,
        storeURL: appImage,
        appContent: appContent,
        category: appCategory,
      );
      setState(() {
        apps.add(app);
        isLoad = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mermaid\'s Tail Quest'),
        actions: [Text(apps.length.toString())],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchApp();
        },
        child: isLoad
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: apps.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1 / 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppDetailPage(app: apps[index]),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 3),
                              spreadRadius: -10,
                              blurRadius: 20,
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          apps[index].storeURL == null
                              ? const SizedBox.shrink()
                              : Image.network(apps[index].storeURL!),
                          const SizedBox(height: 4),
                          Text(
                            apps[index].appName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          const SizedBox(height: 4),
                          Text(apps[index].appContent!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(apps[index].category!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class AppDetailPage extends StatelessWidget {
  final App app;

  const AppDetailPage({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.appName!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            app.storeURL == null
                ? const SizedBox.shrink()
                : Image.network(app.storeURL!),
            const SizedBox(height: 20),
            Text('Name: ${app.appName}'),
            Text('Category: ${app.appContent}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Open app in the app store logic here...
              },
              child: const Text('Open in App Store'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Share app logic here...
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}

class App {
  final String? appName;
  final String? storeURL;
  final String? appContent;
  final String? category;

  App({
    required this.appName,
    required this.storeURL,
    required this.appContent,
    required this.category,
  });
}
