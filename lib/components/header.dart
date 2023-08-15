import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/dialog_panels.dart';

import '../providers.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context, ref) {
    final selectedLang = ref.watch(selectedLanguageProvider);
    final int pageIndex = ref.watch(tabIndexProvider);
    final bool freezeAppBar = ref.watch(freezeAppBarProvider);

    final String title;

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

    void addItemToStock() {
      // ref.read(freezeAppBarProvider.notifier).state = true;
      // ref.read(openPanelProvider.notifier).state = true;

      void createNew() {
        ref.read(freezeAppBarProvider.notifier).state = true;
        ref.read(openPanelProvider.notifier).state = true;
      }

      void pickItem() {
        transferItemDialogPanel(context, ref, ref.watch(recordItemListProvider),
            stockItemListProvider.notifier);
      }

      addItemDialogPanel(
          context: context, createNew: createNew, pickItem: pickItem);
    }

    void addReceiptToReceipt() {}

    return AbsorbPointer(
      absorbing: freezeAppBar,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              //this is a temporary solution
              IconButton(
                onPressed: addItemToStock,
                icon: Icon(
                  Icons.add_box,
                  size: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ]),
            SizedBox(
              height: 40,
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
                            ? Theme.of(context).colorScheme.onPrimary
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
                            ? Theme.of(context).colorScheme.onPrimary
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
