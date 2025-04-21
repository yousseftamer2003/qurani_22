import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/azkar_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/features_screens/widgets/shimmer_effect.dart';
import 'package:share_plus/share_plus.dart';

class AzkarDetailsScreen extends StatefulWidget {
  const AzkarDetailsScreen({super.key, required this.title, required this.id});
  final String title;
  final int id;

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  @override
  void initState() {
    Provider.of<AzkarController>(context, listen: false).getAzkarByCategory(context,widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final langServices = Provider.of<LangServices>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20, color: lightBlue),
        ),
        centerTitle: true,
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
          if(!azkarProvider.isAzkarLoaded){
            return buildShimmerEffect(false);
          }else{
          final azkar = azkarProvider.azkar;
        return SingleChildScrollView(
          child: Column(
            children: List.generate(azkar.length, (index) {
              final zekr = azkar[index];
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Directionality(
                              textDirection: langServices.isArabic? TextDirection.rtl : TextDirection.ltr,
                              child: Expanded(child: Text( langServices.isArabic? zekr.zekrAr : zekr.zekrEn)),
                              ),
                              const SizedBox(width: 5,),
                            GestureDetector(
                              onTap: () {
                                final String sharedText = langServices.isArabic ? zekr.zekrAr : zekr.zekrEn;
                                Share.share(sharedText);
                              },
                              child: SvgPicture.asset('assets/images/Share.svg',height: 20,)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                        onPressed: (){
                          setState(() {
                            if(zekr.count > 0){
                              zekr.count--;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightBlue,
                          foregroundColor: Colors.white,
                          minimumSize: Size(MediaQuery.sizeOf(context).width, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${S.of(context).countForZekr}: ${zekr.count}'),
                            Text(S.of(context).clickHereToCount)
                          ],
                        ) 
                        )
                      ],
                    )
                  ),
                ),
              );
            }),
          ),
        );
          }
        },
      ),
    );
  }
}
