import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/item_card_mini.dart';
import 'package:shoppingapp/models.dart';

import '../providers.dart';

Future<String?> addItemDialogPanel(
    {required BuildContext context,
    required VoidCallback createNew,
    required VoidCallback pickItem,
    required ref}) {
  SelectedLanguage lang = ref.watch(selectedLanguageProvider);
  String title =
      lang == SelectedLanguage.arabic ? "اضف غرض للمخزون" : "Add item to stock";

  String fromNewString =
      lang == SelectedLanguage.arabic ? "انشئ جديد" : "Create New";
  String fromRecordString =
      lang == SelectedLanguage.arabic ? "من السجل" : "From Record";

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(child: Text(title)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, "Adding item");
            pickItem();
          },
          child: Text(fromRecordString),
        ),
        TextButton(
          onPressed: () {
            createNew();
            Navigator.pop(context, 'Creating item');
          },
          child: Text(fromNewString),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    ),
  );
}

Future<String?> transferItemDialogPanel(
    BuildContext context,
    WidgetRef ref,
    List<Item> from,
    StateNotifierProvider<StockItemListNotifier, List<Item>> to) {
  SelectedLanguage lang = ref.watch(selectedLanguageProvider);
  String title =
      lang == SelectedLanguage.arabic ? "اختار الغرض" : "Select Item";

  String cancelString = lang == SelectedLanguage.arabic ? "الغاء" : "Cancel";
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
          child: Text(
        title,
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
            Navigator.pop(context, 'cancel');
          },
          child: Text(cancelString),
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
  StateNotifierProvider<StockItemListNotifier, List<Item>> to,
) {
  int quantity = 0;

  SelectedLanguage lang = ref.watch(selectedLanguageProvider);
  String title =
      lang == SelectedLanguage.arabic ? "الغرض المختار" : "Selected Item";

  String returnString = lang == SelectedLanguage.arabic ? "الرجوع" : "Return";
  String addString = lang == SelectedLanguage.arabic ? "اضف" : "Add";
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
        child: Text(
          title,
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
            ref.read(to.notifier).addItem(itemToAdd);
          },
          child: Text(addString),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Return');
            transferItemDialogPanel(context, ref, from, to);
          },
          child: Text(returnString),
        ),
      ],
    ),
  );
}

Future<String?> changeQuantityDialogPanel(
  BuildContext context,
  WidgetRef ref,
  Item item,
  StateNotifierProvider<StockItemListNotifier, List<Item>> to,
) {
  int quantity = item.quantity;

  SelectedLanguage lang = ref.watch(selectedLanguageProvider);
  String title =
      lang == SelectedLanguage.arabic ? "تغير الكمية" : "Change Quantity";

  String changeString = lang == SelectedLanguage.arabic ? "تغير" : "Change";
  String cancelString = lang == SelectedLanguage.arabic ? "الغاء" : "Cancel";

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Center(
        child: Text(
          title,
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
              ref.read(to.notifier).removeItem(item);

              return;
            }

            Navigator.pop(context, 'Change');

            Item changedItem = Item.copyWithQuantity(item, quantity);
            ref.read(to.notifier).updateItem(changedItem);
          },
          child: Text(changeString),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: Text(cancelString),
        ),
      ],
    ),
  );
}
