import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models.dart';

final openPanelProvider = StateProvider<bool>((ref) => false);

final tabIndexProvider = StateProvider<int>((ref) => 0);

final freezeAppBarProvider = StateProvider<bool>((ref) => false);

final onSplashScreenProvider = StateProvider<bool>((ref) => true);

final selectedLanguageProvider =
    StateProvider<SelectedLanguage>((ref) => SelectedLanguage.english);

enum SelectedLanguage { arabic, english }

class ItemListBaseNotifier extends StateNotifier<List<Item>> {
  ItemListBaseNotifier(super.state);

  void addItem(Item item) {}

  bool itemExist(int id) {
    for (var element in state) {
      if (element.id == id) {
        return true;
      }
    }

    return false;
  }

  void updateItem(Item item) {
    List<Item> list = state;

    for (var element in list) {
      if (element.id == item.id) element = item;
    }

    state = list;
  }
}

final displayLanguageOptionsProvider = StateProvider<bool>((ref) => false);

final stockItemList = StateNotifierProvider<StockItemListNotifier, List<Item>>(
    (ref) => StockItemListNotifier());

class StockItemListNotifier extends ItemListBaseNotifier {
  StockItemListNotifier() : super([]);

  @override
  void addItem(Item item) {
    List<Item> list = state;
    bool itemExist = false;

    for (var element in list) {
      if (element.id == item.id) {
        element.quantity += item.quantity;
        itemExist = true;
      }
    }
    if (!itemExist) {
      state = [...state, item];
    } else {
      state = list;
    }
  }
}

final recordItemList =
    StateNotifierProvider<RecordItemListNotifier, List<Item>>(
        (ref) => RecordItemListNotifier());

class RecordItemListNotifier extends ItemListBaseNotifier {
  RecordItemListNotifier() : super([]);

  @override
  void addItem(Item item) {
    if (itemExist(item.id)) Error();

    item.quantity = 0;

    state = [...state, item];
  }
}
