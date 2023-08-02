import 'package:flutter/material.dart';

import '../models.dart';

class ItemPanel extends StatelessWidget {
  const ItemPanel({super.key, required this.item, required this.displayQuantity});

  final Item item;
  final bool displayQuantity;

  @override
  Widget build(BuildContext context) {
    return Center(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), child: Image.asset(item.photoPath)),
            ),
            Text(item.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconText(icon: Icons.arrow_upward_rounded, string: item.sellingPrice.toString()),
                IconText(icon: Icons.arrow_downward_rounded, string: item.broughtPrice.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (displayQuantity) ...[
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(
                                  color: Colors.blueGrey[50],
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16),
                            ),
                          ] else ...[
                            Icon(
                              Icons.insert_drive_file_outlined,
                              color: Colors.blueGrey[50],
                            )
                          ]
                        ],
                      ),
                    ))
              ],
            )
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
