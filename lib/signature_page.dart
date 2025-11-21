import 'package:flutter/material.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature Range'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Signature & Essentials (placeholder)\nReplace with product grid when ready.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
