import 'package:flutter/material.dart';
import 'package:qurani_22/constants/colors.dart';

class PlanContainer extends StatelessWidget {
  const PlanContainer({super.key, required this.isChosen, required this.price, required this.title, required this.onTap});
  final bool isChosen;
  final String price;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: isChosen ? darkBlue : Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 111,
        width: 111,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.white,
          ),
          color: isChosen ? Colors.white : Colors.transparent,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(price,style: textStyle,),
              Text(title,style: textStyle,),
            ],
          ),
        ),
      ),
    );
  }
}