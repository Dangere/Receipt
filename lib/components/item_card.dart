import 'package:flutter/material.dart';

import '../models.dart';

typedef void ItemCallBack(Item item);

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.item,
      required this.displayQuantity,
      required this.onTab});

  final Item item;
  final bool displayQuantity;
  final ItemCallBack onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTab(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: item.photoPath == null
                      ? const Placeholder()
                      : Image.asset(item.photoPath!),
                ),
              ),
            ),
            Text(item.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconText(
                    icon: Icons.arrow_upward_rounded,
                    string: item.sellingPrice.toString()),
                IconText(
                    icon: Icons.arrow_downward_rounded,
                    string: item.broughtPrice.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("#${item.id}",
                      style: const TextStyle(color: Colors.grey)),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: displayQuantity
                      ? Center(
                          child: Text(
                            item.quantity.toString(),
                            style: TextStyle(
                                color: Colors.blueGrey[50],
                                fontWeight: FontWeight.w200,
                                fontSize: 16),
                          ),
                        )
                      : Icon(
                          Icons.save_alt_rounded,
                          color: Colors.blueGrey[50],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.icon,
    required this.string,
  });

  final IconData icon;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(
          string,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
