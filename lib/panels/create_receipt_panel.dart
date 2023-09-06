import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/alert_dialog_panels.dart';

import '../components/item_card_mini.dart';
import '../models.dart';
import '../providers.dart';

class CreateReceiptPanel extends ConsumerWidget {
  CreateReceiptPanel({super.key});

  final TextEditingController customerNameController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);
    final bool onArabic = selectedLang == SelectedLanguage.arabic;

    final String titleText = onArabic ? "انشاء وصل" : "Create Receipt";
    final String customerNameText = onArabic ? "اسم الزبون" : "Customer Name";
    final String createReceiptText = onArabic ? "إنشاء" : "Create";
    final String addItemText = onArabic ? "اضف غرض" : "Add Item";

    final String emptyString = onArabic ? "فارغ" : "Empty";

    void closePanel() {
      ref.read(openPanelProvider.notifier).state = false;
      ref.read(freezeAppBarProvider.notifier).state = false;
      FocusManager.instance.primaryFocus?.unfocus();
    }

    List<Item> broughtItems = ref.watch(broughtItemListProvider);

    print("added item rn");

    void createReceipt() {
      if (broughtItems.isEmpty || customerNameController.text.isEmpty) return;
      print("create receipt and save it");

      //make dialog alert to confirm making the receipt because it cant be changed

      Receipt newReceipt = Receipt(
          customerName: customerNameController.text,
          broughtItems: broughtItems,
          creationDate: "2023/8/30");
      ref.read(receiptListProvider.notifier).addReceipt(newReceipt);

      ref
          .read(stockItemListProvider.notifier)
          .replaceList(ref.watch(copiedStockItemListProvider));
      closePanel();
    }

    return SizedBox(
      height: 500,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, -1)),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                //close panel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: closePanel, icon: const Icon(null)),
                    Text(
                      titleText,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    IconButton(
                        onPressed: closePanel,
                        icon: const Icon(Icons.close, size: 30))
                  ],
                ),
                SizedBox(
                  height: 1,
                  width: 200,
                  child: Container(
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //customer's name input field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: customerNameText,
                        hintStyle: const TextStyle(),
                        border: InputBorder.none,
                      ),
                      controller: customerNameController,
                      onChanged: (value) => "",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //purchased items list view
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      if (broughtItems.isEmpty)
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
                            itemCount: broughtItems.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  changeQuantityDialogPanel(
                                      context,
                                      ref,
                                      broughtItems[index],
                                      copiedStockItemListProvider,
                                      broughtItemListProvider,
                                      true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ItemCardMini(
                                      item: broughtItems[index],
                                      displayQuantity: true),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //final create receipt button
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: !(broughtItems.isEmpty ||
                                  customerNameController.text.isEmpty)
                              ? const Color.fromARGB(255, 20, 16, 26)
                              : const Color.fromARGB(255, 20, 16, 26)
                                  .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () => createReceipt(),
                        child: Text(
                          createReceiptText,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    //add item to the purchased items
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: TextButton(
                        onPressed: () => transferItemDialogPanel(
                            context,
                            ref,
                            copiedStockItemListProvider,
                            broughtItemListProvider,
                            true),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              addItemText,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
