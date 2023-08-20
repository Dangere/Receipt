import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/items_display_list.dart';
import 'package:shoppingapp/components/slide_up_panel.dart';
import 'package:shoppingapp/panels/create_item_panel.dart';

import '../models.dart';
import '../providers.dart';

class RecordPage extends ConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // List<Item> itemList = List.generate(
    //     25,
    //     (index) => Item(
    //         name: "السلام عليكم $index",
    //         id: 2000,
    //         broughtPrice: 120,
    //         sellingPrice: 200,
    //         quantity: 1,
    //         photoPath: "assets/images/8.PNG"));

    final List<Item> itemList = ref.watch(recordItemListProvider);
    final bool isPanelOpen = ref.watch(openPanelProvider);

    Future<bool> onWillPop() async {
      if (ref.read(openPanelProvider.notifier).state == true) {
        ref.read(openPanelProvider.notifier).state = false;
        ref.read(freezeAppBarProvider.notifier).state = false;
        FocusManager.instance.primaryFocus?.unfocus();

        return false;
      } else {
        return true;
      }
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: Column(
            children: [
              const RecordHeader(),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: SlideUpPanel(
                      body: ItemsList(
                        list: itemList,
                        columnHeight: 270,
                        displayQuantity: false,
                        freezeScroll: false,
                        onCardTab: (Item item) => "",
                      ),
                      panel: CreateItemPanel(
                          targetLists: [recordItemListProvider.notifier]),
                      duration: const Duration(milliseconds: 500),
                      isOpen: isPanelOpen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecordHeader extends ConsumerWidget {
  const RecordHeader({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final selectedLang = ref.watch(selectedLanguageProvider);
    final bool freezeAppBar = ref.watch(freezeAppBarProvider);

    String title = selectedLang == SelectedLanguage.arabic ? "سجل" : "Record";

    return AbsorbPointer(
      absorbing: freezeAppBar,
      child: Container(
        // duration: Duration(seconds: 1),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              //this is a temporary solution
              IconButton(
                onPressed: () {
                  ref.read(freezeAppBarProvider.notifier).state = true;
                  ref.read(openPanelProvider.notifier).state = true;
                },
                icon: Icon(
                  Icons.add_box,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
