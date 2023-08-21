import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/slide_up_panel.dart';
import 'package:shoppingapp/panels/create_receipt_panel.dart';
import '../components/receipt_card.dart';
import '../models.dart';
import '../providers.dart';

class ReceiptsTab extends StatefulWidget {
  const ReceiptsTab({super.key});

  @override
  State<ReceiptsTab> createState() => _ReceiptsTabState();
}

class _ReceiptsTabState extends State<ReceiptsTab>
    with AutomaticKeepAliveClientMixin {
  List<Receipt> receipts = List.generate(
    10,
    (index) => Receipt(
        customerName: "Customer Name",
        broughtItems: [],
        creationDate: "2023/08/23"),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Consumer(builder: (context, ref, child) {
        final bool isPanelOpen = ref.watch(openPanelProvider);
        final int tabIndex = ref.watch(tabIndexProvider);

        // if (isPanelOpen && tabIndex == 1) {
        //   ref
        //       .read(copiedStockItemListProvider.notifier)
        //       .replaceList(ref.read(stockItemListProvider));

        //   print("copying the stock list");
        // }

        return SlideUpPanel(
          body: ListView.builder(
            physics: isPanelOpen ? const NeverScrollableScrollPhysics() : null,
            itemCount: receipts.length,
            itemBuilder: (BuildContext context, int index) {
              return ReceiptCard(
                receipt: receipts[index],
              );
            },
          ),
          panel: CreateReceiptPanel(),
          duration: const Duration(milliseconds: 500),
          isOpen: isPanelOpen,
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
