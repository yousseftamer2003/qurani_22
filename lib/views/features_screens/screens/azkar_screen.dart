import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/azkar_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/features_screens/screens/azkar_details_screen.dart';
import 'package:qurani_22/views/features_screens/widgets/gradient_icon_container.dart';
import 'package:qurani_22/views/features_screens/widgets/shimmer_effect.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  @override
  void initState() {
    Provider.of<AzkarController>(context, listen: false).getCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langServices = Provider.of<LangServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Azkar,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: lightBlue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: lightBlue,
          ),
        ),
      ),
      body: Consumer<AzkarController>(
        builder: (context, azkarProvider, _) {
          if (!azkarProvider.isCategoryLoaded) {
            return buildShimmerEffect(false);
          } else {
            final azkarCategories = azkarProvider.categories;
            return ListView.builder(
              itemCount: azkarCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AzkarDetailsScreen(
                          title: langServices.isArabic? azkarCategories[index].nameAr! : azkarCategories[index].name,
                          id: azkarCategories[index].id,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    color: Colors.white,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const GradientIconContainer(),
                              const SizedBox(width: 10),
                              Text(
                              langServices.isArabic? azkarCategories[index].nameAr! :  azkarCategories[index].name,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: lightBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
// assets\images\azkar_new_icon.svg