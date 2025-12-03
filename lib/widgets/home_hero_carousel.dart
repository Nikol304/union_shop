import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeHeroCarousel extends StatefulWidget {
  const HomeHeroCarousel({super.key});

  @override
  State<HomeHeroCarousel> createState() => _HomeHeroCarouselState();
}

class _HomeHeroCarouselState extends State<HomeHeroCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> slides = [
    {
      'image': 'assets/images/hero_111.png',
      'title': 'Essential Range – Over 20% OFF!',
      'subtitle':
          'Over 20% off our Essential Range. Come and grab yours while stock lasts!',
      'button': 'BROWSE COLLECTION',
      'route': '/collections',
    },
    {
      'image': 'assets/images/merch_drop.png',
      'title': 'New Merch Drop!',
      'subtitle': 'Fresh arrivals are here. Limited stock available.',
      'button': 'SHOP NOW',
      'route': '/merch',
    },
    {
      'image': 'assets/images/mug_hoodie.png',
          
      'title': 'Print Shack Personalisation',
      'subtitle': 'Make it yours with custom designs and embroidery.',
      'button': 'PERSONALISE',
      'route': '/print-shack-personalisation',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Auto-slide every 5 seconds
    Future.delayed(const Duration(seconds: 5), autoSlide);
  }

  void autoSlide() {
    if (!mounted) return;

    int next = _currentIndex + 1;
    if (next == slides.length) next = 0;

    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 5), autoSlide);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      width: double.infinity,
      child: Stack(
        children: [
          // SLIDES
          PageView.builder(
            controller: _controller,
            itemCount: slides.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final slide = slides[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  // BACKGROUND IMAGE
                  Image.network(
                    slide['image']!,
                    fit: BoxFit.cover,
                  ),

                  // DARK OVERLAY
                  Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.45),
                  ),

                  // CONTENT
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slide['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, slide['route']!);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              backgroundColor: const Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              slide['button']!,
                              style: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // DOT INDICATOR
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: slides.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 3,
                  spacing: 8,
                  radius: 4,
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white54,
                ),
              ),
            ),
          ),

          // LEFT ARROW
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: IconButton(
              iconSize: 38,
              color: Colors.white,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                int prev = _currentIndex - 1;
                if (prev < 0) prev = slides.length - 1;
                _controller.animateToPage(
                  prev,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),

          // RIGHT ARROW
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: IconButton(
              iconSize: 38,
              color: Colors.white,
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                int next = _currentIndex + 1;
                if (next == slides.length) next = 0;
                _controller.animateToPage(
                  next,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
