import 'package:flutter/material.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/start/screens/start_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToStart() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const StartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [darkBlue, lightBlue],
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  // First screen
                  _buildPage(
                    image: 'assets/images/mushaf_blue.png',
                    title: S.of(context).Qurancaht,
                    subtitle: S.of(context).WheretheQuranspeakstoyourheart,
                    description: S.of(context).onboardingText,
                  ),

                  _buildPage(
                    image: 'assets/images/location.png',
                    title:  S.of(context).WhyWeNeedLocation,
                    subtitle: S.of(context).ToGetToYouExactPrayerTimeAndHaveTheFullExperienceWithUs,
                    description: S.of(context).startNow,
                    wrapImage: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ElevatedButton(
                onPressed: _currentPage == 0 ? _nextPage : _goToStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width * 0.7, 60),
                ),
                child: Text(
                  _currentPage == 0
                      ? S.of(context).Next
                      : S.of(context).GetStarted,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String subtitle,
    required String description,
    bool wrapImage = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        wrapImage
            ? Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(image, width: 120, height: 120,color: darkBlue,),
            )
            : Image.asset(image),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
