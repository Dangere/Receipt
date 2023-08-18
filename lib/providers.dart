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

  int itemExist(int id) {
    for (var i = 0; i < state.length; i++) {
      if (state[i].id == id) {
        return i;
      }
    }

    return -1;
  }

  void updateItem(Item item) {}

  void removeItem(Item item) {
    final List<Item> list = state;

    int itemExists = itemExist(item.id);

    if (itemExists == -1) Error();

    list.removeAt(itemExists);

    state = [...list];
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
  void updateItem(Item item) {
    if (itemExist(item.id) == -1) Error();

    final List<Item> list = state;
    final Item newItem = Item.copy(item);

    for (int i = 0; i < list.length; i++) {
      if (list[i].id == item.id) {
        list[i] = newItem;
      }
    }

    state = [...list];
  }

  @override
  void addItem(Item item) {
    final List<Item> list = state;

    final Item newItem = Item.copy(item);
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
    if (itemExist(item.id) == -1) Error();

    Item newItem = Item.copy(item);
    newItem.quantity = 0;

    state = [...state, newItem];
  }
}

final recordItemListProvider =
    StateNotifierProvider<RecordItemListNotifier, List<Item>>(
        (ref) => RecordItemListNotifier());
