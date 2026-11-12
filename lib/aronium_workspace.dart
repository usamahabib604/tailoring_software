import 'package:flutter/material.dart';

// نوٹ: اب سارا ماسٹر POS اور ٹیلرنگ لے آؤٹ سیدھا main_screen.dart پر کام کر رہا ہے۔
// یہ فائل اب صرف بیک اپ کے طور پر موجود ہے۔

class AroniumWorkspace extends StatelessWidget {
  const AroniumWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspace Redirect'),
        backgroundColor: const Color(0xFF7CB342),
      ),
      body: const Center(
        child: Text(
          'ماسٹر POS اور ٹیلرنگ لے آؤٹ اب مین سکرین (MainScreen) پر شفٹ ہو چکا ہے۔',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}