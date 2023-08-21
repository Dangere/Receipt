import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/components/alert_dialog_panels.dart';

import '../components/item_card_mini.dart';
import '../models.dart';
import '../providers.dart';

class CreateReceiptPanel extends ConsumerWidget {
  const CreateReceiptPanel({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);
    final bool onArabic = selectedLang == SelectedLanguage.arabic;

    final String titleText = onArabic ? "انشاء وصل" : "Create Receipt";
    final String customerNameText = onArabic ? "اسم الزبون" : "Customer Name";
    final String createReceiptText = onArabic ? "إنشاء" : "Create";
    final String addItemText = onArabic ? "اضف غرض" : "Add Item";

    final String emptyString = onArabic ? "فارغ" : "Empty";

    final TextEditingController customerNameController =
        TextEditingController();

    void closePanel() {
      ref.read(openPanelProvider.notifier).state = false;
      ref.read(freezeAppBarProvider.notifier).state = false;
      FocusManager.instance.primaryFocus?.unfocus();
    }

    List<Item> broughtItems = ref.watch(broughtItemListProvider);

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
                        controller: customerNameController),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: broughtItems.isEmpty
                              ? const Color.fromARGB(255, 20, 16, 26)
                                  .withOpacity(0.5)
                              : const Color.fromARGB(255, 20, 16, 26),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () => "",
                        child: Text(
                          createReceiptText,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
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
