import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/controllers/auto_start_helper.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/controllers/start_controller.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/json/quran_provider.dart';
import 'package:qurani_22/views/start/widgets/gradient_button.dart';
import 'package:qurani_22/views/tabs_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuranController>(context, listen: false).loadJsonAsset();
    Provider.of<LangServices>(context, listen: false).loadLangFromPrefs();
    Provider.of<StartController>(context,listen: false).getCurrentLocation(context, isFirstTime: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.of(context).yourPhoneMayBlockAzanNotificationsInBackground}\n ${S.of(context).pleaseAllowAutoStartForThisApp}',
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AutoStartHelper.openAutoStartSettings();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(S.of(context).settings),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/images/mushaf_blue.png'),
              const SizedBox(height: 90),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                height: 330,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Consumer2<StartController, LangServices>(
                  builder: (context, addressProvider, langProvider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).welcometoTalktoQuran,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          S.of(context).location,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: darkBlue),
                                ),
                                child: Text(
                                  addressProvider.address,
                                  style: const TextStyle(fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                addressProvider.setisLoading(true);
                                addressProvider.getCurrentLocation(context,isFirstTime: true);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: darkBlue),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/loc.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          S.of(context).chooseLanguage,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: langProvider.selectedLang,
                          decoration: InputDecoration(
                            labelText: S.of(context).selectLanguage,
                            labelStyle: const TextStyle(color: darkBlue),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: darkBlue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: darkBlue,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text(
                                S.of(context).arabic,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(
                                S.of(context).english,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              langProvider.selectLang(value);
                            }
                          },
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GradientButton(
                              onPressed: () {
                                if (addressProvider.address.isEmpty || addressProvider.address == 'No Address') {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text(S.of(context).addressRequired),
                                          content: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(S.of(context).clickOn),
                                              SvgPicture.asset(
                                                'assets/images/loc.svg',
                                                width: 20,
                                                height: 20,
                                              ),
                                              Text(S.of(context).toGetYourLocationAndContinue,
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(S.of(context).ok,
                                                style: TextStyle(
                                                  color: darkBlue,
                                                ),
                                              ),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => const TabsScreen(),
                                    ),
                                  );
                                }
                              },
                              label: '',
                              width: 50,
                              height: 50,
                              labelWidget: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

          // **Loading Overlay**
          Consumer<StartController>(
            builder: (context, addressProvider, _) {
              if (addressProvider.isLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.7),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
