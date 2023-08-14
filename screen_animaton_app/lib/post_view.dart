import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with TickerProviderStateMixin {
  bool isLike = false;
  bool readMore = false;
  String body =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  late final AnimationController _controllerRotation = AnimationController(
    value: 1.0,
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final AnimationController _controllerSize = AnimationController(
    value: 1.0,
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );

  late final AnimationController _controllerPosition = AnimationController(
    duration: const Duration(seconds: 6),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animationRotation = CurvedAnimation(
    parent: _controllerRotation,
    curve: Curves.elasticOut,
  );

  late final Animation<double> _animationSize = CurvedAnimation(
    parent: _controllerSize,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controllerRotation.dispose();
    _controllerSize.dispose();
    _controllerPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(-1.0, 0.0), // Başlangıç konumu (ekranın ortasında)
              end: Offset(1.0, 0.0), // Bitiş konumu (sağa ve aşağıya hareket)
            ).animate(_controllerPosition),
            child: Center(
              child: Text(
                'Animasyonlu Metin',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    "https://picsum.photos/2000",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        _controllerRotation.forward(from: 0.0);
                        setState(() {
                          isLike = !isLike;
                        });
                      },
                      child: RotationTransition(
                        turns: _animationRotation,
                        child: isLike
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 32,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 32,
                              ),
                      ),
                    ),
                    const Icon(
                      Icons.comment_outlined,
                      size: 32,
                    ),
                    const Icon(
                      Icons.ios_share_outlined,
                      size: 32,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _controllerSize.forward(from: 0.0);
              setState(() {
                readMore = !readMore;
              });
            },
            child: SizeTransition(
              sizeFactor: _animationSize,
              axis: Axis.vertical,
              child: Text(
                body,
                style: const TextStyle(fontSize: 20),
                overflow: readMore ? null : TextOverflow.ellipsis,
                maxLines: readMore ? null : 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
