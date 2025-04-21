// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/emotions_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';

class ResultContainer extends StatefulWidget {
  const ResultContainer({super.key});

  @override
  State<ResultContainer> createState() => _ResultContainerState();
}

class _ResultContainerState extends State<ResultContainer> {
  final ScreenshotController screenshotController = ScreenshotController();


  void _shareAsText(String text) {
    Share.share(text);
  }

  bool isCapturing = false;

void _captureAndShareScreenshot() async {
  setState(() {
    isCapturing = true;
  });

  await Future.delayed(const Duration(milliseconds: 100)); // Wait for rebuild

  final image = await screenshotController.capture();

  setState(() {
    isCapturing = false;
  });

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
  return Consumer<EmotionsController>(
    builder: (context, emotionProvider, _) {
      if(emotionProvider.result == null) {
        return const Center(
          child: CircularProgressIndicator(color: lightBlue,),
        );
      } else {
        return Screenshot(
          controller: screenshotController,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).hereIsHelpForYourSelectedEmotion,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    emotionProvider.result!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if(isCapturing) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/mushaf_blue.png', width: 50, height: 50),
                        const SizedBox(height: 8),
                        Text('Powered by تحدث مع القران'),
                      ],
                    ),
                  ],
                ) else Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        emotionProvider.regenerateResult();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue.withOpacity(0.1),
                        foregroundColor: darkBlue,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: Text(S.of(context).Regenerate),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: (){
                        _showShareOptions(emotionProvider.result!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightBlue.withOpacity(0.1),
                        foregroundColor: darkBlue,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: SvgPicture.asset(
                        'assets/images/share_icon.svg', 
                        height: 18,
                        color: darkBlue,
                      ),
                      label: Text(S.of(context).share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}
}
