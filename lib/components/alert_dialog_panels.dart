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
    StateNotifierProvider<ItemListBaseNotifier, List<Item>> from,
    StateNotifierProvider<ItemListBaseNotifier, List<Item>> to,
    bool careAboutQuantity) {
  SelectedLanguage lang = ref.watch(selectedLanguageProvider);
  String title =
      lang == SelectedLanguage.arabic ? "اختار الغرض" : "Select Item";

  String emptyString = lang == SelectedLanguage.arabic ? "فارغ" : "Empty";
  String cancelString = lang == SelectedLanguage.arabic ? "الغاء" : "Cancel";

  List<Item> fromList = ref.read(from);

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
        height: 300,
        width: 50,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                if (fromList.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        emptyString,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: fromList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, 'selected an item');

                            selectedItemDialogPanel(context, ref,
                                fromList[index], from, to, careAboutQuantity);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ItemCardMini(
                                item: fromList[index], displayQuantity: true),
                          ),
                        );
                      },
                    ),
                  ),
              ],
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
    StateNotifierProvider<ItemListBaseNotifier, List<Item>> from,
    StateNotifierProvider<ItemListBaseNotifier, List<Item>> to,
    bool careAboutQuantity) {
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
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ItemCardMini(item: item, displayQuantity: true)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                                if (careAboutQuantity &&
                                    quantity == item.quantity) {
                                  return;
                                }

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

            if (careAboutQuantity) {
              ref.read(from.notifier).removeItem(itemToAdd);
            }
          },
          child: Text(addString),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Return');
            transferItemDialogPanel(context, ref, from, to, careAboutQuantity);
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
    StateNotifierProvider<ItemListBaseNotifier, List<Item>> from,
    StateNotifierProvider<ItemListBaseNotifier, List<Item>> to,
    bool careAboutQuantity) {
  int quantity = item.quantity;

  SelectedLanguage lang = ref.watch(selectedLanguageProvider);
  String title =
      lang == SelectedLanguage.arabic ? "تغير الكمية" : "Change Quantity";

  String changeString = lang == SelectedLanguage.arabic ? "تغير" : "Change";
  String cancelString = lang == SelectedLanguage.arabic ? "الغاء" : "Cancel";

  int fromItemQuantity = ref.read(from.notifier).getQuantity(item.id);
  int toItemQuantity = ref.read(to.notifier).getQuantity(item.id);
  int totalQuantity = fromItemQuantity + toItemQuantity;

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
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ItemCardMini(item: item, displayQuantity: true)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                              if (careAboutQuantity &&
                                  quantity == totalQuantity) return;
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
            if (!careAboutQuantity) {
              Item changedItem = Item.copyWithQuantity(item, quantity);
              ref.read(to.notifier).updateItem(changedItem);
              Navigator.pop(context, 'change');

              return;
            }

            Item fromItem = Item.copyWithQuantity(
                item, fromItemQuantity + (item.quantity - quantity));
            Item toItem = Item.copyWithQuantity(
                item, toItemQuantity - (item.quantity - quantity));

            if (fromItemQuantity == 0) {
              ref.read(from.notifier).addItem(fromItem);
            }

            if (toItemQuantity == 0) {
              ref.read(from.notifier).addItem(toItem);
            }

            ref.read(from.notifier).updateItem(fromItem);
            ref.read(to.notifier).updateItem(toItem);

            Navigator.pop(context, 'change');
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
