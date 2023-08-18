import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models.dart';

import '../providers.dart';

class CreateItemPanel extends ConsumerWidget {
  const CreateItemPanel({super.key, required this.targetLists});

  final List<ProviderListenable<ItemListBaseNotifier>> targetLists;

  @override
  Widget build(BuildContext context, ref) {
    final SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);
    final bool onArabic = selectedLang == SelectedLanguage.arabic;

    final String titleText = onArabic ? "إنشاء غرض" : "Create Item";
    final String itemNameText = onArabic ? "اسم الغرض" : "Item Name";
    final String idText = onArabic ? "رقم الغرض" : "Item ID";
    final String broughtText = onArabic ? "سعر الشراء" : "Brought Price";
    final String sellingText = onArabic ? "سعر البيع" : "Selling Price";
    final String createItemText = onArabic ? "إنشاء" : "Create";

    final TextEditingController itemNameController = TextEditingController(),
        idController = TextEditingController(),
        broughtPriceController = TextEditingController(),
        sellingPriceController = TextEditingController();

    void itemAlreadyExistAlert() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alert'),
          content: const Text('Item with this ID already exists'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    void closePanel() {
      ref.read(openPanelProvider.notifier).state = false;
      ref.read(freezeAppBarProvider.notifier).state = false;

      FocusManager.instance.primaryFocus?.unfocus();
    }

    void createItem() {
      if (itemNameController.text.isEmpty ||
          idController.text.isEmpty ||
          broughtPriceController.text.isEmpty ||
          sellingPriceController.text.isEmpty) return;

      for (ProviderListenable<ItemListBaseNotifier> list in targetLists) {
        if (ref.read(list).itemExist(int.parse(idController.text))) {
          itemAlreadyExistAlert();
          return;
        }
      }
      final item = Item(
          name: itemNameController.text,
          id: int.parse(idController.text),
          broughtPrice: int.parse(broughtPriceController.text),
          sellingPrice: int.parse(sellingPriceController.text),
          quantity: 0,
          photoPath: null);

      for (ProviderListenable<ItemListBaseNotifier> list in targetLists) {
        ref.read(list).addItem(item);
      }

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
                offset: const Offset(0, -1)),
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
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        // height: 200,
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200]),
                          child:
                              const Icon(Icons.add_a_photo_outlined, size: 30),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: itemNameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: itemNameText,
                            hintStyle: const TextStyle(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: idController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: idText,
                            hintStyle: const TextStyle(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: broughtPriceController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: broughtText,
                              hintStyle: const TextStyle(),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: sellingPriceController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: sellingText,
                              hintStyle: const TextStyle(),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: createItem,
                      child: Container(
                        padding: const EdgeInsets.all(12) +
                            const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 20, 16, 26),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          createItemText,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
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
