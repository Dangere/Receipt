import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/alert_dialog_panels.dart';
import 'package:shoppingapp/components/slide_up_panel.dart';
import 'package:shoppingapp/panels/create_item_panel.dart';
import 'package:shoppingapp/providers.dart';

import '../components/items_display_list.dart';
import '../models.dart';
// import '../models.dart';

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
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Consumer(
        builder: (context, ref, child) {
          final bool isPanelOpen = ref.watch(openPanelProvider);
          final itemList = ref.watch(stockItemListProvider);

          return SlideUpPanel(
            body: ItemsList(
              list: itemList,
              columnHeight: 270,
              displayQuantity: true,
              freezeScroll: isPanelOpen,
              onCardTab: (Item item) => changeQuantityDialogPanel(context, ref,
                  item, recordItemListProvider, stockItemListProvider, false),
            ),
            panel: CreateItemPanel(targetLists: [
              stockItemListProvider.notifier,
              recordItemListProvider.notifier
            ]),
            duration: const Duration(milliseconds: 500),
            isOpen: isPanelOpen,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
