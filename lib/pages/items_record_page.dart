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

    final List<Item> itemList = ref.watch(recordItemList);
    final bool isPanelOpen = ref.watch(openPanelProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        body: Column(
          children: [
            const RecordHeader(),
            Expanded(
              child: SlideUpPanel(
                body: ItemsList(
                  list: itemList,
                  columnHeight: 270,
                  displayQuantity: false,
                  freezeScroll: false,
                ),
                panel: CreateItemPanel(targetList: recordItemList.notifier),
                duration: const Duration(milliseconds: 500),
                isOpen: isPanelOpen,
              ),
            ),
          ],
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

    String title = selectedLang == SelectedLanguage.arabic ? "سجل" : "Record";

    return AbsorbPointer(
      absorbing: false,
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  color: Theme.of(context).colorScheme.primary,
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

class RecordPanelList extends StatelessWidget {
  const RecordPanelList({
    super.key,
    required this.itemList,
  });

  final List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return ItemsList(
      list: itemList,
      columnHeight: 270,
      displayQuantity: false,
      freezeScroll: false,
    );
  }
}
