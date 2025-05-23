import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/emotions_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';


class EmotionsContainer extends StatefulWidget {
  const EmotionsContainer({super.key});

  @override
  State<EmotionsContainer> createState() => _EmotionsContainerState();
}

class _EmotionsContainerState extends State<EmotionsContainer> {
  @override
  Widget build(BuildContext context) {
    final langServices = Provider.of<LangServices>(context,listen: false);
    return Consumer<EmotionsController>(
      builder: (context, emotionProvider, _) {
        if (!emotionProvider.isEmotionLoaded) {
          return const Center(child: CircularProgressIndicator(color: lightBlue,));
        }else{
      String? selectedEmotion = emotionProvider.selectedEmotion;
      List<String> emotions = langServices.isArabic? emotionProvider.emotions.map((e) => e.nameAr!).toList() : emotionProvider.emotions.map((e) => e.name).toList();
      final emotionObjects = emotionProvider.emotions;
      return  Container(
        padding: const EdgeInsets.all(5),
        height: MediaQuery.sizeOf(context).height * 0.25,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(emotions.length, 
            (index) {
              final emotion = emotions[index];
              final isSelected = selectedEmotion == emotion;
              final emotionObject = emotionObjects[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if(selectedEmotion == emotion){
                      selectedEmotion = null;
                      emotionProvider.setSelectedEmotion(null,false);
                    }else{
                      selectedEmotion = emotion;
                      emotionProvider.setSelectedEmotion(emotionObject,langServices.isArabic);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.withValues(alpha: 0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        emotion,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
          }
      },
      
    );
  }
}
