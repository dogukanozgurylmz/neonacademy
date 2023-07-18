import 'package:flutter/material.dart';

class CustomTextFieldView extends StatefulWidget {
  const CustomTextFieldView({super.key});

  @override
  State<CustomTextFieldView> createState() => _CustomTextFieldViewState();
}

class _CustomTextFieldViewState extends State<CustomTextFieldView> {
  bool isEmail = true;
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text("Ad-Soyad Giriniz"),
                labelStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              minLines: 1,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
            ),
            TextField(
              decoration: InputDecoration(
                label: const Text("E-posta Giriniz"),
                labelStyle: const TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
                errorText: isEmail ? null : 'Geçersiz e-posta formatı',
              ),
              onChanged: (value) {
                setState(() {
                  isEmail = isValidEmail(value);
                });
              },
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text("Telefon Numarası Giriniz"),
                labelStyle: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                ),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
          ],
        ),
      ),
    );
  }
}
