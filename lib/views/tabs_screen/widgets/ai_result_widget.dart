import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:qurani_22/constants/colors.dart';

class AIResultWidget extends StatefulWidget {
  final String result;
  final String? note;

  const AIResultWidget({required this.result, this.note, super.key});

  @override
  State<AIResultWidget> createState() => _AIResultWidgetState();
}

class _AIResultWidgetState extends State<AIResultWidget> {
  bool isTyping = true; // Control typing state
  bool isTextVisible = false; // Control visibility of the result text

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    // Show typing dots for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isTyping = false;
    });

    // Delay before showing the result text to simulate typing effect
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isTextVisible = true; // Show result text after typing animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isTyping
          ? _buildTypingDots() // Show typing dots
          : _buildTypingText(widget.result, widget.note),
    );
  }

  // Build typing dots animation
  Widget _buildTypingDots() {
    return Center(
      key: const ValueKey('typing'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          TypingDots(),
        ],
      ),
    );
  }

  // Build typing text animation and show the note after typing ends
  Widget _buildTypingText(String text, String? note) {
    return Column(
      key: const ValueKey('typed'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isTextVisible) // Show text after typing animation completes
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                text,
                textStyle: const TextStyle(fontSize: 16, height: 1.5),
                speed: const Duration(milliseconds: 30),
              ),
            ],
            totalRepeatCount: 1,
          ),
        const Divider(height: 30),
        if (isTextVisible)
         note != null ? Text(
            note,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ) : const SizedBox(),
      ],
    );
  }
}

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return FadeTransition(
          opacity: _animations[i],
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '.',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: lightBlue),
            ),
          ),
        );
      }),
    );
  }
}
