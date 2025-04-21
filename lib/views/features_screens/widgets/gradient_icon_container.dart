import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qurani_22/constants/colors.dart';

class GradientIconContainer extends StatelessWidget {
  const GradientIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 122, 228, 255),
            darkBlue
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset('assets/images/azkar_new_icon.svg'),
      ),
    );
  }
}