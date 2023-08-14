import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Hero Game'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  "Welcome to the maze. If you succeed, you are ready for the real world",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                  Colors.redAccent,
                )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HeroView()));
                },
                child: const Text("Next"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final Map<String, String> Levels = {
  'assets/hero_game/1.png': 'Down',
  'assets/hero_game/2.png': 'Right',
  'assets/hero_game/3.png': 'Up',
  'assets/hero_game/4.png': 'Right',
  'assets/hero_game/5.png': 'Down',
  'assets/hero_game/6.png': 'Right',
  'assets/hero_game/7.png': 'Right',
};

class HeroView extends StatefulWidget {
  const HeroView({Key? key}) : super(key: key);

  @override
  _HeroViewState createState() => _HeroViewState();
}

class _HeroViewState extends State<HeroView>
    with SingleTickerProviderStateMixin {
  int currentLevel = 0;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  int falseCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.0, 0.0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateSlideAnimation() {
    _slideAnimation = Tween<Offset>(
      begin: Offset(currentLevel == 0 ? 0.0 : -1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      for (int i = 0; i < falseCount; i++)
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Stack(
                    children: [
                      if (currentLevel > 0)
                        SlideTransition(
                          position: _slideAnimation,
                          child: Image.asset(
                            Levels.entries.elementAt(currentLevel - 1).key,
                            key: const Key('oldImage'),
                          ),
                        ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: Image.asset(
                          Levels.entries.elementAt(currentLevel).key,
                          key: const Key('newImage'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (currentLevel < Levels.length - 1)
                  ArrowButtons(
                    heartStates:
                        List.generate(3, (index) => index < falseCount),
                    enabledArrowButton:
                        Levels.entries.elementAt(currentLevel).value,
                    onArrowPressed: (direction) async {
                      if (Levels.entries.elementAt(currentLevel).value ==
                          direction) {
                        setState(() {
                          currentLevel++;
                        });
                      } else {
                        setState(() {
                          falseCount--;
                        });
                        if (falseCount == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameOverView(),
                            ),
                          );
                        } else {
                          _showAlertDialog(context);
                        }
                      }
                      _updateSlideAnimation();
                      _controller.forward(from: 0.0);
                    },
                  ),
                const SizedBox(height: 50),
                if (currentLevel == Levels.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentLevel = 0;
                        falseCount = 3;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(200, 60),
                    ),
                    child: const Text(
                      'Restart',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wrong direction'),
          content: Text('Remaining Life: ${falseCount}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateSlideAnimation();
                _controller.forward(from: 0.0);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class GameOverView extends StatelessWidget {
  const GameOverView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Game Over'),
          backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowButtonInfo {
  final IconData iconData;
  final bool isEnabled;

  ArrowButtonInfo(this.iconData, this.isEnabled);
}

bool? status = true;
final List<ArrowButtonInfo> icons = [
  ArrowButtonInfo(Icons.arrow_upward, status!),
  ArrowButtonInfo(Icons.arrow_back, status!),
  ArrowButtonInfo(Icons.arrow_downward, status!),
  ArrowButtonInfo(Icons.arrow_forward, status!),
];

int falseCount = 3;

class ArrowButtons extends StatelessWidget {
  const ArrowButtons({
    Key? key,
    required this.heartStates,
    required this.enabledArrowButton,
    required this.onArrowPressed,
  }) : super(key: key);

  final List<bool> heartStates;
  final String enabledArrowButton;
  final Function(String) onArrowPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(60, 60),
              ),
              onPressed: icons[0].isEnabled
                  ? () {
                      if (enabledArrowButton == 'Up') {
                        onArrowPressed('Up');
                      } else {
                        _showAlertDialog(context);
                      }
                    }
                  : () => _showAlertDialog(context),
              child: Icon(
                icons[0].iconData,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(60, 60),
                  ),
                  onPressed: icons[1].isEnabled &&
                          icons[1].iconData == Icons.arrow_back &&
                          enabledArrowButton == 'Left'
                      ? () => onArrowPressed('Left')
                      : () => _showAlertDialog(context),
                  child: Icon(
                    icons[1].iconData,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(60, 60),
                  ),
                  onPressed: icons[2].isEnabled &&
                          icons[2].iconData == Icons.arrow_downward &&
                          enabledArrowButton == 'Down'
                      ? () => onArrowPressed('Down')
                      : () => _showAlertDialog(context),
                  child: Icon(
                    icons[2].iconData,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(60, 60),
                  ),
                  onPressed: icons[3].isEnabled &&
                          icons[3].iconData == Icons.arrow_forward &&
                          enabledArrowButton == 'Right'
                      ? () => onArrowPressed('Right')
                      : () => _showAlertDialog(context),
                  child: Icon(
                    icons[3].iconData,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wrong direction'),
          content: Text('Remaining Life: ${falseCount - 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                falseCount--;
                if (falseCount == 0) {
                  // Navigate to the Game Over View
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameOverView(),
                    ),
                  );
                  falseCount = 3;
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
