import 'package:flutter/material.dart';
import 'package:screen_animaton_app/post_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animasyon"),
      ),
      body: const PostView(),
    );
  }
}

          // SlideTransition(
          //   position: Tween<Offset>(
          //     begin: Offset(-3.0, 0.0), // Başlangıç konumu (ekranın ortasında)
          //     end: Offset(3.0, 0.0), // Bitiş konumu (sağa ve aşağıya hareket)
          //   ).animate(_controllerPosition),
          //   child: Center(
          //     child: Text(
          //       'Animasyonlu Metin',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //   ),
          // ),