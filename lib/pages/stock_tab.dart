import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/slide_up_panel.dart';
import 'package:shoppingapp/panels/create_item_panel.dart';
import 'package:shoppingapp/providers.dart';

import '../components/items_display_list.dart';
import '../models.dart';

class StockTab extends StatefulWidget {
  const StockTab({super.key});

  @override
  State<StockTab> createState() => _StockTabState();
}

class _StockTabState extends State<StockTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Item> itemList = List.generate(
        7,
        (index) => Item(
            name: "السلام عليكم $index",
            id: 2000,
            broughtPrice: 120,
            sellingPrice: 200,
            quantity: 1,
            photoPath: "assets/images/8.PNG"));

    return Consumer(
      builder: (context, ref, child) {
        final bool isPanelOpen = ref.watch(openPanelProvider);

        return SlideUpPanel(
          body: ItemsList(
            list: itemList,
            columnHeight: 270,
          ),
          panel: CreateItemPanel(),
          duration: const Duration(seconds: 1),
          isOpen: isPanelOpen,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
