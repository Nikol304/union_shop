import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Limit content width to look like a real website
    final double maxTextWidth = 800;
    final double horizontalPadding =
        screenWidth > 1100 ? 120 : (screenWidth > 800 ? 64 : 24);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Top full-width container
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    /// Title (centered)
                    const Text(
                      "About us",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Centered text block with max width
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxTextWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome to the Union Shop!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!",
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "All online purchases are available for delivery or instore collection!",
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "We hope you enjoy our products as much as we enjoy offering them to you. "
                            "If you have any questions or comments, please don’t hesitate to contact us at hello@upsu.net.",
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Happy shopping!\nThe Union Shop & Reception Team",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
