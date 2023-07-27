import 'package:firebase_task/service/auth_service.dart';
import 'package:firebase_task/view/login_view.dart';
import 'package:flutter/material.dart';

import 'bottom_navbar_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.init();
    navigate();
  }

  // Future<void> signOut() async {
  //   await _authService.signOut();
  // }

  void navigate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_authService.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBarView(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
