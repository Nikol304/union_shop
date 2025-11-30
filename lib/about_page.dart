import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // placeholder for help links
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 1100 ? 120 : (screenWidth > 800 ? 64 : 24);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 40,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Union Shop',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Union Shop supports student life with a curated range of merchandise and services. We work with local printers and designers to bring you exclusive drops and reliable fulfilment.',
                  ),
                ],
              ),
            ),

            // Shared footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
