import 'package:flutter/material.dart';
import 'package:qurani_22/constants/colors.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double width;
  final double height;
  final Widget? labelWidget;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = 86, 
    this.height = 40.0, 
    this.labelWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              lightBlue,
              darkBlue,
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent, 
            padding: EdgeInsets.zero, 
          ),
          onPressed: onPressed,
          child: Center(
            child: labelWidget ?? Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600), // Button text style
            )
          ),
        ),
      ),
    );
  }
}