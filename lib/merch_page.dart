import 'package:flutter/material.dart';

class MerchPage extends StatelessWidget {
  const MerchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Merchandise'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Merchandise page (placeholder)\nReplace with real content when ready.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
