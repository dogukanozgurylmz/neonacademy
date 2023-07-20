import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class LottieView extends StatefulWidget {
  const LottieView({super.key});

  @override
  State<LottieView> createState() => _LottieViewState();
}

class _LottieViewState extends State<LottieView> {
  double percentage = 0.0;

  bool isProcessing = false;

  bool isCompleted = false;

  GlobalKey _repaintBoundaryKey = GlobalKey();

  Future<void> startSharpeningProcess() async {
    while (percentage <= 99.9) {
      print(isProcessing);
      setState(() {
        percentage += 0.1;
      });
      if (!isProcessing) {
        return;
      }
      await Future.delayed(const Duration(microseconds: 1));
    }
    setState(() {
      isProcessing = false;
    });
    if (percentage.toInt() == 99) {
      setState(() {
        isCompleted = true;
      });
      await Future.delayed(
          const Duration(milliseconds: 100)); // Delay before saving the image
      saveSharpenedImage();
    }
  }

  void stopSharpeningProcess() {
    setState(() {
      isProcessing = false;
    });
  }

  void resetProcess() {
    setState(() {
      percentage = 0.0;
      isCompleted = false;
    });
  }

  Future<void> saveSharpenedImage() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return saveSharpenedImage();
      }
      var image = await boundary.toImage();
      final directory =
          await getApplicationDocumentsDirectory(); // Changed to application documents directory
      final imagePath = '${directory.path}/sharpened_image.png';
      File(imagePath).writeAsBytesSync(
          (await image.toByteData(format: ImageByteFormat.png))!
              .buffer
              .asUint8List());

      var status = await Permission.storage.request();
      if (status.isGranted) {
        final result = await ImageGallerySaver.saveFile(imagePath);
        print('Keskinleştirilmiş fotoğraf kaydedildi: $imagePath');
        print('Kayıt durumu: $result');
      } else {
        print('Dış depolama izni reddedildi.');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Dış Depolama İzni Gerekli'),
              content: Text(
                  'Fotoğrafı kaydetmek için dış depolama iznine ihtiyacımız var.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Hata: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Fotoğraf kaydedilemedi.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget buildCompletedWidget() {
    return RepaintBoundary(
      key: _repaintBoundaryKey,
      child: Lottie.asset(
        'assets/completed.json',
        width: 200,
        height: 200,
        animate: isCompleted,
        onLoaded: (composition) {
          if (percentage.toInt() == 99) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Image.network(
                      "https://picsum.photos/1000/1000",
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildProcessingWidget() {
    if (percentage == 0) {
      return Blur(
        blur: 5,
        child: Image.network(
          "https://picsum.photos/1000/1000",
        ),
      );
    } else {
      return Lottie.asset(
        'assets/loading_animation.json',
        width: 200,
        height: 200,
        animate: isProcessing,
        onLoaded: (composition) async {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fotoğraf Keskinleştirme"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isCompleted ? buildCompletedWidget() : buildProcessingWidget(),
            SizedBox(height: 20),
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            isCompleted
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isProcessing = !isProcessing;
                      });
                      await startSharpeningProcess();
                    },
                    child:
                        Text(isProcessing ? "İşlemi Durdur" : "Keskinleştir"),
                  ),
            !isCompleted
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: resetProcess,
                    child: Text("Reset"),
                  ),
          ],
        ),
      ),
    );
  }
}
