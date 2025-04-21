import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Consumer<InAppPurchasesController>(
        builder: (context, iapProvider, _) {
          return Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    const Text('Unlock Premium',style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.w700),),
                    const SizedBox(height: 40,),
                    const Row(
                      children: [
                        Icon(Icons.check_circle_sharp,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('No ads',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Row(
                      children: [
                        Icon(Icons.check_circle_sharp,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('No generation limits',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.2),
                    const Text('Pick your plan',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(iapProvider.products.length,
                      (index) {
                        final product = iapProvider.products[index];
                        final String title = product.title.contains('month') ? 'month' : 'year';
                        return PlanContainer(
                          onTap: (){
                            setState(() {
                              selectedPlan = index;
                            });
                          },
                          isChosen: selectedPlan == index, 
                          price: product.price, 
                          title: title);
                      },)
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: BuyPlanContainer(
                  onTap: () {
                    iapProvider.buySubscription(iapProvider.products[selectedPlan]);
                  },
                )
                )
            ],
          );
        },
      ),
    );
  }
}