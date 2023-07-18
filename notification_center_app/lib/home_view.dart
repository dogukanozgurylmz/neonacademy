import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'message_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String message = "This message is important";
  TextEditingController codeTextEditingController = TextEditingController();
  String generateCode = "";
  late Timer _timer;
  bool isFinished = false;
  int _start = 15;

  Future<void> toast(String code) async {
    await Fluttertoast.showToast(
        msg: generateCode,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void generateRandomCode() {
    final random = Random();
    const characters = '0123456789';
    final code = StringBuffer();
    for (int i = 0; i < 5; i++) {
      code.write(characters[random.nextInt(characters.length)]);
    }
    print(code);
    generateCode = code.toString();
  }

  bool codeControle() {
    setState(() {});
    if (generateCode != codeTextEditingController.text.trim() ||
        codeTextEditingController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> popRep() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomeView(),
    ));
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> showCodeDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Code: $generateCode'),
      ),
    );
  }

  Future<void> showMessageDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: isFinished
            ? const Text(
                "This message is important",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            : Text(
                "$_start",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("DECRYPT"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: codeTextEditingController,
                  onEditingComplete: () async {
                    if (codeControle()) {
                      await toast(generateCode);
                    }
                  },
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!codeControle()) {
                    generateRandomCode();
                    await showCodeDialog();
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MessageView(),
                    ));
                  }
                },
                child: Text(codeControle() ? "Decode" : "Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
