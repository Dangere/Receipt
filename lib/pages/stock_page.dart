import 'package:flutter/material.dart';

import '../components/item_display_list.dart';
import '../models.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage>
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

    return ItemsList(
      list: itemList,
      columnHeight: 270,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
