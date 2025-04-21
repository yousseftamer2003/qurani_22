import 'package:flutter/material.dart';

class BuyPlanContainer extends StatelessWidget {
  const BuyPlanContainer({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: const GradientBorderButton()),
      ),
    );
  }
}


class GradientBorderButton extends StatelessWidget {
  const GradientBorderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientBorderPainter(),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white, // Keep background white
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.orange, Colors.yellow],
          ).createShader(bounds),
          child: const Center(
            child: Text(
              "Upgrade to premium",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White to apply gradient effect
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.orange, Colors.yellow],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(6),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

