import 'package:flutter/material.dart';

class HalloweenPage extends StatelessWidget {
  const HalloweenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halloween'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Halloween collection (placeholder)\nAdd seasonal items here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
