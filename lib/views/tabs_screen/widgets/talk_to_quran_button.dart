import 'package:flutter/material.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/tabs_screen/screens/result_screen.dart';

class TalkToQuranButton extends StatefulWidget {
  const TalkToQuranButton({super.key});

  @override
  State<TalkToQuranButton> createState() => _TalkToQuranButtonState();
}

class _TalkToQuranButtonState extends State<TalkToQuranButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // Keep repeating back and forth
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultScreen(),
          ),
        );
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: 60,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1 + _controller.value * 2, 0),
                end: Alignment(1 - _controller.value * 2, 0),
                colors: const [
                  lightBlue,
                  darkBlue,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/mushaf_blue.png',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  S.of(context).talkToQuran,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
