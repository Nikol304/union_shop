import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This is a placeholder About page for the Union Shop.\n\n'
              'Here you would put information about the shop, its mission, '
              'history, or staff. For now this is dummy text to demonstrate '
              'the page layout. Feel free to replace this text with real content.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            SizedBox(height: 12),
            Text(
              'Our Goals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              '• Provide quality merchandise to the community.\n'
              '• Support student-led initiatives.\n'
              '• Foster a welcoming shopping experience.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
