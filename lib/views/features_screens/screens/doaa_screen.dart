import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/duaa_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/models/duaa_model.dart';
import 'package:qurani_22/views/features_screens/widgets/shimmer_effect.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DoaaScreen extends StatefulWidget {
  const DoaaScreen({super.key});

  @override
  State<DoaaScreen> createState() => _DoaaScreenState();
}

class _DoaaScreenState extends State<DoaaScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    Provider.of<DuaaController>(context, listen: false).getDuaaList(context);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).todaysduaa,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: lightBlue),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: lightBlue,
          ),
        ),
      ),
      body: Consumer<DuaaController>(
        builder: (context, duaaProvider, _) {
          if (!duaaProvider.isduaaLoaded) {
            return buildShimmerEffect(true);
          } else {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: duaaProvider.duaaList.length,
                    itemBuilder: (context, index) {
                      final duaa = duaaProvider.duaaList[index];
                      return _buildDuaaCard(duaa);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: duaaProvider.duaaList.length,
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                      activeDotColor: lightBlue,
                      dotColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDuaaCard(Duaa duaa) {
    final langServices = Provider.of<LangServices>(context, listen: false);
  return Card(
    color: Colors.transparent,
    elevation: 0, // No shadow to match the image style
    margin: const EdgeInsets.fromLTRB(16, 34, 16, 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 219, 233, 243), Color(0xFFFFFFFF)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: [
          // Background image with opacity
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.1, // Lower opacity for mosque image
              child: Image.asset(
                'assets/images/mosque_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  langServices.isArabic? duaa.duaaAr : duaa.duaaEn,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),
                Text(
                  langServices.isArabic? duaa.duaaEn : duaa.duaaAr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (duaa.note != null) ...[
                  const SizedBox(height: 12),
                  const Divider(color: Colors.black45),
                  const SizedBox(height: 8),
                  Text(
                    duaa.note!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


}
