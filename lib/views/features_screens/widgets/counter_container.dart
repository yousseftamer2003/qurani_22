import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/sebha_controller.dart';
import 'package:qurani_22/generated/l10n.dart';

class CounterContainer extends StatelessWidget {
  final String phrase;

  const CounterContainer({super.key, required this.phrase});

  @override
  Widget build(BuildContext context) {
    final sebhaController = Provider.of<SebhaController>(context);
    int count = sebhaController.sebhaCounters[phrase] ?? 0;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.19,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [lightBlue, darkBlue],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$count",
                  style: TextStyle(color: Colors.white, fontSize: 60)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => sebhaController.reset(phrase),
                child: Text(S.of(context).reset, style: const TextStyle(color: Colors.white,fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
