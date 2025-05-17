import 'package:flutter/material.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/start/screens/start_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
            const SizedBox(height: 100),
            Image.asset('assets/images/mushaf_blue.png'),
            const SizedBox(height: 10),
            Text(
              S.of(context).Qurancaht,
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              S.of(context).WheretheQuranspeakstoyourheart,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).onboardingText,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const StartScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: Size(MediaQuery.sizeOf(context).width * 0.7, 60),
            ), 
            child: Text(S.of(context).GetStarted,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}
