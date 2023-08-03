// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../components/item_panel.dart';
import '../models.dart';
// import '../providers.dart';

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
        6,
        (index) => Item(
            name: "السلام عليكم $index",
            id: 2000,
            broughtPrice: 120,
            sellingPrice: 200,
            quantity: 1,
            photoPath: "assets/images/8.PNG"));

    // return ListView.builder(
    //   itemCount: (itemList.length / 2).round(),
    //   itemBuilder: (BuildContext context, int index) {
    //     return TesttingItem(
    //       itemList: itemList,
    //       index: index,
    //     );
    //   },
    // );

    // return GridView.builder(
    //     itemCount: itemList.length,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2, childAspectRatio: 1 / 2),
    //     scrollDirection: Axis.vertical,
    //     itemBuilder: (context, index) =>
    //         // ItemWidget(itemList: itemList, index: index),
    //         // ItemWidget(itemList: itemList, index: index));
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             height: 10,
    //             width: 10,
    //             color: Colors.red,
    //           ),
    //         ));
// using staggeredgridview package
    return AlignedGridView.count(
      itemCount: itemList.length,
      crossAxisCount: 2,
      itemBuilder: (context, index) => SizedBox(
        height: 270,
        child: ItemWidget(itemList: itemList, index: index),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TesttingItem extends StatelessWidget {
  const TesttingItem({super.key, required this.itemList, required this.index});

  final List<Item> itemList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0) +
          const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 270,
        child: Row(
          children: [
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
                    : Container(
                        color: Colors.red,
                      ))
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.itemList,
    required this.index,
  });

  final List<Item> itemList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      //EdgeInsets.symmetric(horizontal: 10.0) + EdgeInsets.symmetric(vertical: 5)
      child: ItemPanel(
        item: itemList[index],
        displayQuantity: true,
      ),
    );
  }
}
