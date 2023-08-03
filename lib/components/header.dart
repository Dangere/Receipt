import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
    required this.pageController,
    // required this.scaffoldDrawer,
  });

  final PageController pageController;
  // final Drawer scaffoldDrawer;

  @override
  Widget build(BuildContext context, ref) {
    final selectedLang = ref.watch(selectedLanguageProvider);
    final int pageIndex = ref.watch(pageIndexProvider);
    final bool freezeAppBar = ref.watch(freezeAppBarProvider);

    String title;

    switch (pageIndex) {
      case 0:
        title = selectedLang == SelectedLanguage.arabic ? "مخزون" : "Stock";
      case 1:
        title =
            selectedLang == SelectedLanguage.arabic ? "إيصالات" : "Receipts";
      case 2:
        title = selectedLang == SelectedLanguage.arabic ? "سجل" : "Record";

        break;
      default:
        title = "";
    }

    return AbsorbPointer(
      absorbing: freezeAppBar,
      child: Container(
        // duration: Duration(seconds: 1),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              //this is a temporary solution
              IconButton(
                onPressed: () => "",
                icon: const Icon(null),
              ),
            ]),
            Visibility(
              visible: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    icon: Icon(Icons.store_mall_directory_rounded,
                        size: 30,
                        color: pageIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey),
                  ),
                  IconButton(
                    onPressed: () => pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    ),
                    icon: Icon(Icons.receipt,
                        size: 30,
                        color: pageIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
