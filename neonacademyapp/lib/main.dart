import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({required this.sharedPreferences, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomeView(sharedPreferences: sharedPreferences),
    );
  }
}

class HomeView extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const HomeView({required this.sharedPreferences, Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController howManyTimesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool areYouWent = false;
  List<String> travelList = [];
  List<Map<String, dynamic>> travelMapList = [];

  @override
  void initState() {
    super.initState();
    loadTravel();
  }

  Future<void> submit() async {
    List<String>? stringList = widget.sharedPreferences.getStringList('travel');
    if (stringList != null) {
      travelList = stringList;
    }

    Map<String, dynamic> data = {
      'areYouWent': areYouWent,
      'howManyTimes': areYouWent
          ? (howManyTimesController.text.trim().isEmpty
              ? 0
              : int.parse(howManyTimesController.text.trim()))
          : 0,
      'name': nameController.text.trim(),
    };
    String jsonData = jsonEncode(data);
    travelList.add(jsonData);

    await widget.sharedPreferences.setStringList('travel', travelList);
    loadTravel();
  }

  void loadTravel() {
    List<String>? stringList = widget.sharedPreferences.getStringList('travel');
    travelMapList.clear();
    if (stringList != null) {
      setState(() {
        for (var string in stringList) {
          travelMapList.add(jsonDecode(string));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bu yere daha önce gittiniz mi?"),
              Checkbox(
                value: areYouWent,
                onChanged: (value) {
                  setState(() {
                    areYouWent = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              if (areYouWent) ...[
                const Text("Bu yere kaç kere gittiniz?"),
                TextField(
                  controller: howManyTimesController,
                ),
              ],
              const SizedBox(height: 10),
              const Text("Ziyaret etmek istediğiniz yerin adı nedir?"),
              TextField(
                controller: nameController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: const Text("Gönder"),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: travelMapList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(travelMapList[index]['name']),
                      subtitle: Text(
                          "${travelMapList[index]['howManyTimes']} kere ziyaret ettiniz"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
