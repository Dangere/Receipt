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

  List<Item> storedItems() {
    return state;
  }
}

final displayLanguageOptionsProvider = StateProvider<bool>((ref) => false);

final stockItemListProvider =
    StateNotifierProvider<StockItemListNotifier, List<Item>>(
        (ref) => StockItemListNotifier());

class StockItemListNotifier extends ItemListBaseNotifier {
  StockItemListNotifier() : super([]);

  @override
  void addItem(Item item) {
    List<Item> list = state;

    Item newItem = Item.copy(item);
    if (newItem.quantity == 0) newItem.quantity = 1;

    bool itemExist = false;

    for (int i = 0; i < list.length; i++) {
      if (list[i].id == item.id) {
        itemExist = true;
        newItem.quantity += list[i].quantity;
        list[i] = newItem;
      }
    }

    if (itemExist) {
      state = [...list];
    } else {
      state = [...state, newItem];
    }
  }
}

class RecordItemListNotifier extends ItemListBaseNotifier {
  RecordItemListNotifier() : super([]);

  @override
  void addItem(Item item) {
    if (itemExist(item.id)) Error();

    Item newItem = Item.copy(item);
    newItem.quantity = 0;

    state = [...state, newItem];
  }
}

final recordItemListProvider =
    StateNotifierProvider<RecordItemListNotifier, List<Item>>(
        (ref) => RecordItemListNotifier());
