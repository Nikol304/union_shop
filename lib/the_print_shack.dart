// lib/the_print_shack.dart
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        width > 900 ? 96.0 : (width > 600 ? 48.0 : 24.0);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main content
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Page title
                  const Text(
                    'The Union Print Shack',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Image strip (3 images side-by-side on desktop, stacked on mobile)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth >= 900;
                      final imageWidgets = [
                        _PrintImage(
                          imageUrl:
                              'https://images.pexels.com/photos/7671166/pexels-photo-7671166.jpeg',
                        ),
                        _PrintImage(
                          imageUrl:
                              'https://images.pexels.com/photos/4061381/pexels-photo-4061381.jpeg',
                        ),
                        _PrintImage(
                          imageUrl:
                              'https://images.pexels.com/photos/6311575/pexels-photo-6311575.jpeg',
                        ),
                      ];

                      if (isWide) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imageWidgets
                              .map(
                                (img) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: img,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return Column(
                          children: imageWidgets
                              .map(
                                (img) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 16.0),
                                  child: img,
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 40),

                  // Text sections
                  const _TextSection(
                    heading: 'Make It Yours at The Union Print Shack',
                    body:
                        "Want to add a personal twist to your Union gear? "
                        "Our Print Shack team can add heat-pressed names, numbers, "
                        "and custom text to clothing. Drop by the shop and we’ll "
                        "help you choose the right item and design.",
                  ),
                  const SizedBox(height: 24),

                  const _TextSection(
                    heading: 'Uni Gear or Your Gear – We’ll Personalise It',
                    body:
                        "Whether you’re wearing official university merch or a hoodie "
                        "you already own, we can personalise both. Bring your items in, "
                        "tell us what you’d like printed, and we’ll help you create "
                        "something that feels uniquely yours.",
                  ),
                  const SizedBox(height: 24),

                  const _TextSection(
                    heading: 'Simple Pricing, No Surprises',
                    body:
                        "Personalisation is kept affordable with clear pricing. "
                        "Small text or a chest logo costs around the price of a coffee, "
                        "and larger back prints are only a little more. Turnaround is "
                        "usually within a few working days, and we’ll let you know when "
                        "your order is ready to collect.",
                  ),
                  const SizedBox(height: 24),

                  const _TextSection(
                    heading: 'Personalisation Terms & Conditions',
                    body:
                        "We print your text exactly as it is given to us, whether online "
                        "or in-person. Please double-check spellings and whether you want "
                        "upper- or lower-case letters. Because items are customised, we’re "
                        "not able to offer refunds or exchanges on personalised products.",
                  ),
                  const SizedBox(height: 24),

                  const _TextSection(
                    heading: 'Ready to Make It Yours?',
                    body:
                        "Pop into the shop or get in touch to start your design. "
                        "Let’s create something personal with The Union Print Shack.",
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

class _PrintImage extends StatelessWidget {
  final String imageUrl;

  const _PrintImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  final String heading;
  final String body;

  const _TextSection({
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
