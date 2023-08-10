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

Future<String?> transferItemDialogPanel(
    BuildContext context,
    WidgetRef ref,
    ProviderListenable<ItemListBaseNotifier> from,
    ProviderListenable<ItemListBaseNotifier> to) {
  List<Item> fromList = ref.read(from).storedItems();

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
              itemCount: fromList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: ItemCardMini(
                      item: fromList[index], displayQuantity: true),
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
