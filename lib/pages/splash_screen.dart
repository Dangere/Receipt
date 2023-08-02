import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/providers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     Color(0xFF801BD0),
            //     Color(0xFF64C6FD),
            //   ],
            // ),
            gradient: RadialGradient(
              // focal: Alignment.center,
              // transform: ,
              radius: 2,
              center: Alignment.bottomCenter,
              // begin: Alignment.topRight,
              // end: Alignment.bottomLeft,
              colors: [
                // Colors.blueGrey,
                // Colors.blue.shade800,
                Colors.blueGrey.shade100,

                // Colors.blueGrey.shade800,
                Colors.blueGrey.shade900,
              ],
            ),
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Receipt",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final bool displayLanguageOptions = ref.watch(displayLanguageOptionsProvider);
                final SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);

                return Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(50)),
                            child: Container(
                              color: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  ref.read(displayLanguageOptionsProvider.notifier).state =
                                      !displayLanguageOptions;
                                },
                                child: SizedBox(
                                  height: 60,
                                  width: 45,
                                  child: Transform.translate(
                                      offset: const Offset(3, 0),
                                      child: const Icon(
                                        Icons.language_outlined,
                                        size: 30,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(10)),
                            child: Container(
                              color: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  ref.read(onSplashScreenProvider.notifier).state = false;
                                  ref.read(displayLanguageOptionsProvider.notifier).state = false;
                                },
                                child: SizedBox(
                                  height: 60,
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      selectedLang == SelectedLanguage.arabic
                                          ? "متابعة"
                                          : "Continue",
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      LanguageSelection(displayOptions: displayLanguageOptions),
                      // Visibility(visible: displayLanguageOptions, child: const LanguageSelection())
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key, required this.displayOptions});

  final bool displayOptions;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);

      TextStyle options = const TextStyle(fontSize: 16);

      return Container(
        // color: Colors.red,
        child: ClipRect(
          child: AnimatedSlide(
            offset: displayOptions ? Offset.zero : const Offset(0, -1),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutSine,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<SelectedLanguage>(
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.black45),
                          value: SelectedLanguage.english,
                          groupValue: selectedLang,
                          onChanged: (SelectedLanguage? value) {
                            ref.read(selectedLanguageProvider.notifier).state = value!;
                          },
                        ),
                        Text(
                          'English',
                          style: options,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<SelectedLanguage>(
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.black45),
                          value: SelectedLanguage.arabic,
                          groupValue: selectedLang,
                          onChanged: (SelectedLanguage? value) {
                            ref.read(selectedLanguageProvider.notifier).state = value!;
                          },
                        ),
                        Text(
                          'عربي',
                          style: options,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
