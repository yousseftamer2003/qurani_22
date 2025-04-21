import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/sebha_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/features_screens/widgets/click_widget.dart';
import 'package:qurani_22/views/features_screens/widgets/counter_container.dart';
import 'package:qurani_22/views/features_screens/widgets/sebha_header_widget.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).sebha,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: lightBlue),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: lightBlue),
          ),
        ),
        body: Consumer<SebhaController>(
          builder: (context, sebhaProvider, _) {
            if (sebhaProvider.selectedPhrase == null) {
              return const Center(
                  child: CircularProgressIndicator(
                color: lightBlue,
              ));
            } else {
              return Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SebhaHeaderWidget(),
                          const SizedBox(height: 20),
                          CounterContainer(
                            phrase: sebhaProvider.selectedPhrase!,
                          ),
                          const SizedBox(height: 20),
                          const ClickWidget(),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: MediaQuery.sizeOf(context).width * 0.36,
                      child: GestureDetector(
                          onTap: () {
                            sebhaProvider.increment(sebhaProvider.selectedPhrase!);
                          },
                          child: SvgPicture.asset('assets/images/clickme.svg')))
                ],
              );
            }
          },
        ));
  }
}
