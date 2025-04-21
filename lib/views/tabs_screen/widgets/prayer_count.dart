import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/controllers/home_controller.dart';
import 'package:qurani_22/generated/l10n.dart';

class PrayerCount extends StatelessWidget {
  const PrayerCount({super.key, required this.isClicked, required this.isResultShown});
  final bool isClicked;
  final bool isResultShown;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
            builder: (context, homeProvider, _) {
              final width = isResultShown? 0.015 : 0.06;
              return Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isClicked ? 0 : 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.2)
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * width),
                        Text(
                          S.of(context).timeUntilNextPrayer,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          homeProvider.countdown,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 40),
                        ),
                        Text("${S.of(context).timeUntilNextPrayer} ${homeProvider.nextPrayerName}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}