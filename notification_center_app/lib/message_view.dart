import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notification_center_app/home_view.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late Timer _timer;
  bool isFinished = false;
  int _start = 15;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void navigateBackAfterDelay() {
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
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
            navigateBackAfterDelay();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 102, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isFinished
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
          ],
        ),
      ),
    );
  }
}
