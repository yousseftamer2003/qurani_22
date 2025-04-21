import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/controllers/sebha_controller.dart';
import 'package:qurani_22/generated/l10n.dart';

class ClickWidget extends StatelessWidget {
  const ClickWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final sebhaController = Provider.of<SebhaController>(context, listen: false);
        sebhaController.increment(sebhaController.selectedPhrase!);
      },
      child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  S.of(context).clickHereToCount,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
    );
  }
}