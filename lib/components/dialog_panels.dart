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
      content: SizedBox(
        height: 120,
        child: StatefulBuilder(
          builder: ((context, setState) {
            return Column(
              children: [
                Container(
                  color: Colors.grey[400],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: ItemCardMini(item: item, displayQuantity: true)),
                ),
                Container(
                  color: const Color.fromRGBO(224, 224, 224, 1),
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity == 0) return;
                              quantity--;
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: quantity == 0
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(quantity.toString()),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (quantity == 0) return;
            Navigator.pop(context, 'Add');

            Item itemToAdd = Item.copyWithQuantity(item, quantity);
            ref.read(to).addItem(itemToAdd);
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

Future<String?> changeQuantityDialogPanel(
  BuildContext context,
  WidgetRef ref,
  Item item,
  ProviderListenable<ItemListBaseNotifier> to,
) {
  int quantity = item.quantity;
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
        child: Text(
          'Change Quantity',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: SizedBox(
        height: 120,
        child: StatefulBuilder(
          builder: ((context, setState) {
            return Column(
              children: [
                Container(
                  color: Colors.grey[400],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: ItemCardMini(item: item, displayQuantity: true)),
                ),
                Container(
                  color: const Color.fromRGBO(224, 224, 224, 1),
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity == 0) return;
                              quantity--;
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: quantity == 0
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(quantity.toString()),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (quantity == 0) {
              Navigator.pop(context, 'remove');
              ref.read(to).removeItem(item);

              return;
            }

            Navigator.pop(context, 'Change');

            Item changedItem = Item.copyWithQuantity(item, quantity);
            ref.read(to).updateItem(changedItem);
          },
          child: const Text('Change'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
