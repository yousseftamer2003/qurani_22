import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/sebha_controller.dart';


class SebhaHeaderWidget extends StatefulWidget {
  const SebhaHeaderWidget({super.key});

  @override
  State<SebhaHeaderWidget> createState() => _SebhaHeaderWidgetState();
}

class _SebhaHeaderWidgetState extends State<SebhaHeaderWidget> {
  final PageController _pageController = PageController(initialPage: 0);

  void _nextPage(int length) {
    if (_pageController.page!.toInt() < length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _previousPage() {
    if (_pageController.page!.toInt() > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SebhaController>(
      builder: (context, sebhaProvider, _) {
        final tasabeh = sebhaProvider.sebhaCounters.keys.toList();
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: tasabeh.length,
                    onPageChanged: (i) {
                      sebhaProvider.setSelectedPhrase(tasabeh[i]);
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          sebhaProvider.selectedPhrase ?? '',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: _previousPage,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _nextPage(tasabeh.length),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tasabeh.length,
                (index) => AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _pageController.hasClients &&
                                _pageController.page?.round() == index
                            ? lightBlue
                            : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
