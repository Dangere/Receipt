import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoppingapp/models.dart';

import 'item_card.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.list, required this.columnHeight});

  final List<Item> list;
  final double columnHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: AlignedGridView.count(
        itemCount: list.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) => SizedBox(
          height: columnHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: ItemCard(
              item: list[index],
              displayQuantity: true,
            ),
          ),
        ),
      ),
    );
  }
}
