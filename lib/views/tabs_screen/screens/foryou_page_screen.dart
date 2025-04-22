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
  late ForYouPageController _forYouPageController;
  late LangServices _langProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _forYouPageController = Provider.of<ForYouPageController>(context);
    _langProvider = Provider.of<LangServices>(context, listen: false);

    if (!_forYouPageController.isForYouPageLoaded) {
      _forYouPageController.getForYouPage(context);
    }
  }

  void _shareAsText(String text) {
    Share.share(text);
  }

  void _captureAndShareScreenshot(ScreenshotController controller) async {
    final image = await controller.capture();
    if (image == null) return;

    final directory = await Directory.systemTemp.createTemp();
    final imagePath = '${directory.path}/hadith_screenshot.png';
    final file = File(imagePath);
    await file.writeAsBytes(image);

    Share.shareXFiles([XFile(imagePath)]);
  }

  void _showShareOptions(String text, ScreenshotController controller) {
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
                  _captureAndShareScreenshot(controller);
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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/for_you_background.png'),
              fit: BoxFit.cover,
            ),
          ),
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
                  final screenshotController = ScreenshotController();

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.transparent,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Screenshot(
                      controller: screenshotController,
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
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header row
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

                              // Arabic or English text
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  _langProvider.isArabic
                                      ? content['arabic'] ?? ''
                                      : content['english'] ?? '',
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

                              // Translation
                              Text(
                                _langProvider.isArabic
                                    ? content['english'] ?? ''
                                    : content['arabic'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),

                              // Source
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
                                    _showShareOptions(
                                      _langProvider.isArabic
                                          ? content['arabic']
                                          : content['english'],
                                      screenshotController,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
