// import 'dart:js_interop';

import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../components/item_panel.dart';
import '../models.dart';
// import '../providers.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Item> itemList = List.generate(
        5,
        (index) => Item(
            name: "السلام عليكم $index",
            id: 2000,
            broughtPrice: 120,
            sellingPrice: 200,
            quantity: 1,
            photoPath: "assets/images/8.PNG"));

    return ListView.builder(
      itemCount: (itemList.length / 2).round(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0) +
              const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 270,
            child: Row(children: [
              Expanded(
                child: ItemPanel(
                  item: itemList[(index * 2)],
                  displayQuantity: true,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: itemList.asMap().containsKey((index * 2) + 1)
                    ? ItemPanel(
                        item: itemList[(index * 2) + 1],
                        displayQuantity: true,
                      )
                    : Container(),
              )
            ]),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
