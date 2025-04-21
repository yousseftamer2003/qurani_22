import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/for_you_page_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/features_screens/widgets/shimmer_effect.dart';

import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

class ForyouPageScreen extends StatefulWidget {
  const ForyouPageScreen({super.key});

  @override
  State<ForyouPageScreen> createState() => _ForyouPageScreenState();
}

class _ForyouPageScreenState extends State<ForyouPageScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    Provider.of<ForYouPageController>(context, listen: false)
        .getForYouPage(context);
    super.initState();
  }

  void _shareAsText(String text) {
    Share.share(text);
  }

  void _captureAndShareScreenshot() async {
    final image = await screenshotController.capture();
    if (image == null) return;

    final directory = await Directory.systemTemp.createTemp();
    final imagePath = '${directory.path}/hadith_screenshot.png';
    final file = File(imagePath);
    await file.writeAsBytes(image);

    Share.shareXFiles([XFile(imagePath)]);
  }

  void _showShareOptions(String text) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.text_fields, color: darkBlue),
                title: Text(S.of(context).shareAsText),
                onTap: () {
                  Navigator.pop(context);
                  _shareAsText(text);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image_outlined, color: darkBlue),
                title: Text(S.of(context).shareAsScreenshot),
                onTap: () {
                  Navigator.pop(context);
                  _captureAndShareScreenshot();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LangServices>(context, listen: false);
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/for_you_background.png'),
          fit: BoxFit.cover,
        )),
      ),
      Consumer<ForYouPageController>(
        builder: (context, forYouProvider, _) {
          if (!forYouProvider.isForYouPageLoaded) {
            return buildShimmerEffect(false);
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: forYouProvider.randomizedContent.length,
              itemBuilder: (context, index) {
                final content = forYouProvider.randomizedContent[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Colors.transparent, // Transparent so gradient shows
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 235, 247, 255),
                          Color(0xFFFFFFFF)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header row with title and type
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    content['type'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    content['type'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                langProvider.isArabic? content['arabic'] ?? '' : content['english']?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // English translation
                              Text(
                                langProvider.isArabic? content['english'] ?? '' : content['arabic']?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),

                              // Source or note
                              const SizedBox(height: 8),
                              Text(
                                content['source'] ??
                                    content['note'] ??
                                    'No Notes',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),

                              // Share button
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/images/share_icon.svg',
                                    width: 25,
                                  ),
                                  onPressed: () {
                                     _showShareOptions(langProvider.isArabic ? content['arabic'] : content['english']);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      )
    ]);
  }
}
