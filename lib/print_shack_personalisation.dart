// lib/print_shack_page.dart
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            constraints: const BoxConstraints(maxWidth: 1000),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Page title
                Text(
                  'The Union Print Shack',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),

                // 3-image banner like the website
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AspectRatio(
                    aspectRatio: 16 / 5, // wide strip
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/UniversityHoodieFront_1024x1024@2x.jpg?v=1689855600',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _imagePlaceholder(),
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/PrintShack_1024x1024@2x.jpg?v=1689855600',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _imagePlaceholder(),
                          ),
                        ),
                        Expanded(
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/YourNameHere_1024x1024@2x.jpg?v=1689855600',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _imagePlaceholder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Text content – headings + paragraphs
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _SectionBlock(
                        heading: 'Make It Yours at The Union Print Shack',
                        body:
                            "Want to add a personal touch? We’ve got you covered with heat-pressed customisation on all our clothing. "
                            "Swing by the shop – our team’s always happy to help you pick the right gear and answer any questions.",
                      ),
                      SizedBox(height: 16),
                      _SectionBlock(
                        heading: 'Uni Gear or Your Gear – We’ll Personalise It',
                        body:
                            "Whether you choose official university clothing from the Union Shop or bring in your own, we can personalise it for you. "
                            "Add your name, course, society, nickname or short message to create something that’s uniquely yours.",
                      ),
                      SizedBox(height: 16),
                      _SectionBlock(
                        heading: 'Simple Pricing, No Surprises',
                        body:
                            "Customising your gear won’t break the bank – just £3 for one line of text or a small chest logo, and £5 for two lines "
                            "or a large back logo. Turnaround time is up to three working days, and we’ll let you know as soon as it’s ready to collect.",
                      ),
                      SizedBox(height: 16),
                      _SectionBlock(
                        heading: 'Personalisation Terms & Conditions',
                        body:
                            "We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible "
                            "for any spelling errors, so please ensure your chosen text is clearly displayed in either capitals or lowercase. "
                            "Refunds are not provided for any personalised items.",
                      ),
                      SizedBox(height: 16),
                      _SectionBlock(
                        heading: 'Ready to Make It Yours?',
                        body:
                            "Pop in or get in touch today – let’s create something uniquely you with our personalisation service – The Union Print Shack!",
                      ),
                    ],
                  ),
                ),

                // You can leave footer to your global layout (like on HomeScreen)
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String heading;
  final String body;

  const _SectionBlock({
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: headingStyle,
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

Widget _imagePlaceholder() {
  return Container(
    color: Colors.grey[200],
    child: const Center(
      child: Icon(
        Icons.image_not_supported,
        color: Colors.grey,
      ),
    ),
  );
}
