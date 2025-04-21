import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/home_controller.dart';
import 'package:qurani_22/generated/l10n.dart';


class PrayerTimesContainer extends StatelessWidget {
  const PrayerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeProvider, _) {
        if(!homeProvider.isLoaded){
          return const Center(child: CircularProgressIndicator(color: darkBlue,),);
        }else{
          return Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [lightBlue, darkBlue],
              stops: [0.2, 0.8],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text(
                  S.of(context).fajr,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  homeProvider.prayerTimes!.fajr,
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
              Column(children: [
                Text(
                  S.of(context).Shurooq,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  homeProvider.prayerTimes!.sunrise,
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
              Column(children: [
                Text(
                  S.of(context).dhuhr,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  homeProvider.prayerTimes!.dhuhr,
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
              Column(children: [
                Text(
                  S.of(context).asr,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  homeProvider.prayerTimes!.asr,
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
              Column(children: [
                Text(
                  S.of(context).maghrib,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  homeProvider.prayerTimes!.maghrib,
                  style: const TextStyle(color: Colors.white),
                ),
              ]),
              Column(children: [
                Text(
                  S.of(context).isha,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  homeProvider.prayerTimes!.isha,
                  style: const TextStyle(color: Colors.white),
                ),
              ])
            ],
          ),
        );
        }
      },
    );
  }
}
