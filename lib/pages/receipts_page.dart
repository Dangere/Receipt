import 'package:flutter/material.dart';
import '../components/receipt_panel.dart';
import '../models.dart';

class ReceiptsPage extends StatefulWidget {
  const ReceiptsPage({super.key});

  @override
  State<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> with AutomaticKeepAliveClientMixin {
  List<Receipt> receipts = List.generate(
      10,
      (index) =>
          Receipt(customerName: "Customer Name", broughtItems: [], creationDate: "2023/08/23"));

  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("Rebuilding Receipts Page");
    return ListView.builder(
      itemCount: receipts.length,
      itemBuilder: (BuildContext context, int index) {
        return ReceiptPanel(
          receipt: receipts[index],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
