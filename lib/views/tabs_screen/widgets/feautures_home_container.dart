import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/sebha_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/features_screens/screens/azkar_screen.dart';
import 'package:qurani_22/views/features_screens/screens/doaa_screen.dart';
import 'package:qurani_22/views/features_screens/screens/sebha_screen.dart';
import 'package:qurani_22/views/tabs_screen/screens/quran_page.dart';


class FeauturesHomeContainer extends StatelessWidget {
  const FeauturesHomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              final sebhaController = Provider.of<SebhaController>(context,listen:false);
              sebhaController.setSelectedPhrase(sebhaController.sebhaCounters.keys.toList()[0]);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>  const SebhaScreen())
              );
            } ,
            child: feautureItem(title: S.of(context).sebha, icon: "assets/images/sebha.svg",)),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>  const QuranPage())
              );
            },
            child: feautureItem(title: S.of(context).Mushaf, icon: "assets/images/mushaf.svg",)),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>  const AzkarScreen())
              );
            },
            child: feautureItem(title: S.of(context).Azkar, icon: "assets/images/azkar.svg",)),
          
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=>  const DoaaScreen())
              );
            },
            child: feautureItem(title: S.of(context).Doaa, icon: "assets/images/sebha.svg",)),
        ],
      ),
    );
  }
  Widget feautureItem({required String title, required String icon}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(
            top: 20,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(189, 239, 255, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: SvgPicture.asset(icon,colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),),),
        ),
        const SizedBox(height: 5,),
        Text(title),
        const SizedBox(height: 15,),
      ],
    );
  }
}