import 'package:flutter/material.dart';

class AlertDialogView extends StatefulWidget {
  const AlertDialogView({super.key});

  @override
  State<AlertDialogView> createState() => _AlertDialogViewState();
}

class _AlertDialogViewState extends State<AlertDialogView> {
  final TextEditingController _controller = TextEditingController();
  String buttonText = "Alert Dialog";
  String buttonText2 = "";
  List<String> event = [
    "Olay 1",
    "Olay 2",
    "Olay 3",
    "Olay 4",
    "Olay 5",
    "Olay 6",
  ];
  List<String> selectedEvent = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Dialog"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Düğmenin başlığı"),
                    content: Text("İçerik"),
                  );
                },
              );
            },
            child: Text(buttonText),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      title: Text("Düğmenin başlığı"),
                      content: Text(buttonText2 == "" ? "İçerik" : buttonText2),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              buttonText2 = "buton 1";
                            });
                          },
                          child: Text("Buton 1"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              buttonText2 = "buton 2";
                            });
                          },
                          child: Text("Buton 2"),
                        ),
                      ],
                    );
                  });
                },
              );
            },
            child: Text(buttonText),
          ),
          Text(_controller.text),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: TextField(
                      controller: _controller,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _controller;
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Ekle"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(buttonText),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      content: Column(
                        children: event
                            .map((e) => ListTile(
                                  title: Text(e.toString()),
                                  leading: Checkbox(
                                    value: selectedEvent.contains(e)
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      if (selectedEvent.contains(e)) {
                                        setState(() {
                                          selectedEvent.remove(e);
                                        });
                                      } else {
                                        setState(() {
                                          selectedEvent.add(e);
                                        });
                                      }
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _controller;
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Ekle"),
                        ),
                      ],
                    );
                  });
                },
              );
            },
            child: Text(buttonText),
          ),
          ListView.builder(
            itemCount: selectedEvent.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(selectedEvent[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
