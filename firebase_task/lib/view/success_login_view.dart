import 'package:flutter/material.dart';

class SuccessfulLoginScreen extends StatelessWidget {
  const SuccessfulLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Successful!'),
            ElevatedButton(
              onPressed: () {
                // Çıkış yap ve hesap oluşturma ekranına geri dön.
                // FirebaseAuth.instance.signOut();
                // Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
