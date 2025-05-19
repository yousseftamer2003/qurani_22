import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/tabs_screen/widgets/buy_plan_container.dart';
import 'package:qurani_22/views/tabs_screen/widgets/plan_container.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int selectedPlan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Consumer<InAppPurchasesController>(
        builder: (context, iapProvider, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).UnlockPremium,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_sharp, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          S.of(context).NoAds,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_sharp, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          S.of(context).noGenerationLimits,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_sharp, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          S.of(context).SmartTasbihtotrackyourdhikr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_sharp, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          S.of(context).PersonalizedDuasforyourfeelings,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_sharp, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          S.of(context).Fasterexperienceandexclusiveupdates,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.045),
                    // New motivational text
                    Text(
                      S.of(context).Yourheartdeservesthefullexperience,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).Subscribenowandfeelthedifference,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      S.of(context).pickUrPlan,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        iapProvider.products.length,
                        (index) {
                          final product = iapProvider.products[index];
                          final String title = product.title.contains('Month')
                              ? S.of(context).month
                              : S.of(context).year;
                          return PlanContainer(
                            onTap: () {
                              setState(() {
                                selectedPlan = index;
                              });
                            },
                            isChosen: selectedPlan == index,
                            price: product.price,
                            title: title,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: BuyPlanContainer(
                  onTap: () {
                    iapProvider.buySubscription(
                      iapProvider.products[selectedPlan],
                    );
                  },
                  onTextTapped: () {
                    iapProvider.restorePurchases();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
