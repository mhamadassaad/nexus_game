import 'package:flutter/material.dart';

// نموذج البيانات (Model)
class OnboardingSlide {
  final int id;
  final String title;
  final String description;
  String image;

  OnboardingSlide({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentSlide = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      id: 1,
      title: "Level Up Your Gear",
      description: "Discover the most advanced peripherals and components used by pro esports athletes.",
      image:  "assets/images/O1.png",
    ),
    OnboardingSlide(
      id: 2,
      title: "Global Marketplace",
      description: "Connect with players worldwide to trade skins, keys, and limited edition drops.",
      image: "assets/images/O2.png",
    ),
    OnboardingSlide(
      id: 3,
      title: "Daily Loot Boxes",
      description: "Log in every day to claim exclusive rewards and rare items for your character.",
      image: "assets/images/O3.png",
    ),
  ];

  void _nextSlide() {
    if (_currentSlide < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617), // slate-950
      body: Stack(
        children: [
          // Background Image with Animation
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(
              key: ValueKey(_currentSlide),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _slides[_currentSlide].image.startsWith('http')
                  ? NetworkImage(_slides[_currentSlide].image) as ImageProvider
                  : AssetImage(_slides[_currentSlide].image) as ImageProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0x990F172A), // slate-900/60
                  Color(0xFF020617), // slate-950
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            ),
          ),

          // "LEVEL" Background Text
          Positioned(
            top: 60,
            left: 20,
            child: Opacity(
              opacity: 0.1,
              child: Text(
                "LEVEL ${_currentSlide + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orbitron', // تأكد من إضافة الخط في pubspec.yaml
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentSlide = index),
                    itemCount: _slides.length,
                    itemBuilder: (context, index) {
                      final slide = _slides[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              slide.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF22D3EE), // cyan-400
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(color: Color(0xFF22D3EE), blurRadius: 10),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              slide.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFCBD5E1), // slate-300
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Indicators (Dots)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (idx) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: idx == _currentSlide ? 32 : 16,
                      decoration: BoxDecoration(
                        color: idx == _currentSlide 
                            ? const Color(0xFF22D3EE) 
                            : const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: idx == _currentSlide 
                            ? [const BoxShadow(color: Color(0xFF22D3EE), blurRadius: 8)]
                            : [],
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 40),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _nextSlide,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22D3EE),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          _currentSlide == _slides.length - 1 ? "GET STARTED" : "CONTINUE",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onFinish,
                        child: const Text(
                          "SKIP INTRO",
                          style: TextStyle(color: Color(0xFF64748B), letterSpacing: 2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}