import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/item_card_mini.dart';
import 'package:shoppingapp/models.dart';

import '../providers.dart';

Future<String?> addItemDialogPanel(
    {required BuildContext context,
    required VoidCallback createNew,
    required VoidCallback pickItem}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Center(child: Text('Add item to stock')),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, "Adding item");
            pickItem();
          },
          child: const Text('From Record'),
        ),
        TextButton(
          onPressed: () {
            createNew();
            Navigator.pop(context, 'Creating item');
          },
          child: const Text('Create New'),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    ),
  );
}

Future<String?> transferItemDialogPanel(BuildContext context, WidgetRef ref,
    List<Item> from, ProviderListenable<ItemListBaseNotifier> to) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
          child: Text(
        'Select Item',
        style: Theme.of(context).textTheme.titleMedium,
      )),
      content: SizedBox(
        height: 300,
        width: 50,
        child: Container(
          color: Colors.grey[400],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ListView.builder(
              itemCount: from.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, 'selected an item');

                    selectedItemDialogPanel(
                        context, ref, from[index], from, to);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child:
                        ItemCardMini(item: from[index], displayQuantity: true),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'close');
          },
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

Future<String?> selectedItemDialogPanel(
  BuildContext context,
  WidgetRef ref,
  Item item,
  List<Item> from,
  ProviderListenable<ItemListBaseNotifier> to,
) {
  int quantity = 0;
  item.quantity = 1;
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
        child: Text(
          'Selected Item',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: Column(
        children: [
          Container(
            color: Colors.grey[400],
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: ItemCardMini(item: item, displayQuantity: true)),
          ),
          Container(
            color: Colors.grey[300],
            child: SizedBox(
              width: 90,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () => quantity++, icon: Icon(Icons.add)),
                  Text(quantity.toString())
                ],
              ),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Add');
            ref.read(to).addItem(item);
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Return');
            transferItemDialogPanel(context, ref, from, to);
          },
          child: const Text('Return'),
        ),
      ],
    ),
  );
}
