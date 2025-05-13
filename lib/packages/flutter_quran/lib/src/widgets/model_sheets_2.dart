import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:share_plus/share_plus.dart';


void showOptionsMenu(BuildContext context, int surah, int verse) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (ctx) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.play_arrow),
            title: const Text("Listen to verse"),
            onTap: () {
              String audio = getAudioURLByVerse(surah, verse);
              String surahName = getSurahName(surah);
              String surahNameAr = getSurahNameArabic(surah);
              Navigator.pop(ctx);
              showAudioPlayer(context, audio, surahName, surahNameAr);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("مشاركة"),
            onTap: () {
              Share.share(getVerse(surah, verse));
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void showAudioPlayer(BuildContext context, String audioUrl, String surahName,
      String surahNameAr) {
    final AudioPlayer player = AudioPlayer();
    Duration totalDuration = Duration.zero;
    Duration currentPosition = Duration.zero;
    bool isPlaying = false;
    bool isPlayed = false;

    player.setSourceUrl(audioUrl); // Set the audio source

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Listen to the total duration of the audio
            player.onDurationChanged.listen((Duration duration) {
              setState(() => totalDuration = duration);
            });

            // Listen to the current position of the audio
            player.onPositionChanged.listen((Duration position) {
              setState(() => currentPosition = position);
            });

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3, // Thin track height
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6), // Small thumb
                      overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 10), // Overlay effect when dragging
                      activeTrackColor: Colors.blue, // Progressed part color
                      inactiveTrackColor:
                          Colors.black, // Background track color
                      thumbColor: Colors.blue, // Thumb color
                    ),
                    child: Slider(
                      value: totalDuration.inSeconds > 0
                          ? currentPosition.inSeconds.toDouble()
                          : 0.0,
                      min: 0.0,
                      max: totalDuration.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() =>
                            currentPosition = Duration(seconds: value.toInt()));
                        player.seek(currentPosition);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 50,
                        color: Color.fromRGBO(0, 139, 183, 1)),
                    onPressed: () async {
                      if (!isPlayed) {
                        await player.play(UrlSource(audioUrl));
                        setState(() => isPlayed = true);
                      }
                      if (isPlaying) {
                        await player.pause();
                      } else {
                        await player.resume();
                      }
                      setState(() => isPlaying = !isPlaying);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color.fromRGBO(0, 139, 183, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(surahName, style: const TextStyle(color: Colors.white),),
                        Text(surahNameAr, style: const TextStyle(color: Colors.white),)
                      ],
                    ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }