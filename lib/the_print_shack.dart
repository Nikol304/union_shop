// lib/print_shack_page.dart
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/app_footer.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const accentColour = Color(0xFF4d2963);

    return Scaffold(
      appBar: const AppHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page title
                    Text(
                      'The Union Print Shack',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Let’s create something uniquely yours with our personalisation service.",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Hero-style image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          // You can swap this for your own image later
                          'https://shop.upsu.net/cdn/shop/files/ClassicHoodies_UniShop_1024x1024@2x.jpg?v=1689855600',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Sections similar to the website content
                    const _InfoCard(
                      title: 'Make It Yours at The Union Print Shack',
                      body:
                          "Want to add a personal touch to your uni gear? The Print Shack offers on-site heat-pressed customisation on a wide range of clothing. "
                          "Drop into the shop and the team can help you choose the right item and answer any questions you have about the process.",
                    ),
                    const SizedBox(height: 16),

                    const _InfoCard(
                      title: 'Uni Gear or Your Own Clothing',
                      body:
                          "You can personalise official university-branded clothing from the Union Shop or bring in your own hoodies and tees. "
                          "Whether it’s your name, society, course or a short message, we’ll help you turn it into something you’ll actually want to wear.",
                    ),
                    const SizedBox(height: 16),

                    const _PricingCard(),
                    const SizedBox(height: 16),

                    const _InfoCard(
                      title: 'Personalisation Terms & Conditions',
                      body:
                          "All text is printed exactly as provided, online or in person, so please double-check spelling and capitalisation before confirming your order. "
                          "Personalised items are made just for you and therefore can’t be refunded or exchanged unless there is a fault with the product itself.",
                    ),
                    const SizedBox(height: 16),

                    const _InfoCard(
                      title: 'Ready to Get Started?',
                      body:
                          "Add your clothing to your basket and then choose a personalisation option, or visit the Union Shop in person to chat to the team. "
                          "From one-off gifts to group hoodies, The Union Print Shack is here to help you stand out.",
                    ),
                    const SizedBox(height: 32),

                    // Opening hours block (similar to the site)
                    const _OpeningHoursCard(),

                    const SizedBox(height: 32),

                    // Call to action
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // You can later navigate to a dedicated "personalisation" flow
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColour,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'FIND OUT MORE',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Shared site footer (full width)
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;

  const _InfoCard({
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border(
            left: BorderSide(
              color: const Color(0xFF4d2963),
              width: 3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  const _PricingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simple Pricing, No Surprises',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Personalising your clothing is straightforward and affordable:",
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 8),
            const _BulletPoint(
              text: '£3 for one line of text or a small chest logo.',
            ),
            const _BulletPoint(
              text: '£5 for two lines of text or a large back logo.',
            ),
            const _BulletPoint(
              text:
                  'Turnaround time is usually up to three working days. You’ll be contacted when your order is ready to collect.',
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ',
            style: TextStyle(
              height: 1.5,
            )),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _OpeningHoursCard extends StatelessWidget {
  const _OpeningHoursCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Opening Hours',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 12),
            const Text(
              '(Term Time)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Monday – Friday: 9:00am – 4:00pm',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 12),
            const Text(
              '(Outside of Term Time / Consolidation Weeks)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Monday – Friday: 10:00am – 3:00pm',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 12),
            const Text(
              'You can still browse and purchase online 24/7.',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
