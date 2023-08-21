class Item {
  String name;
  int id;
  int broughtPrice;
  int sellingPrice;
  int quantity;
  String? photoPath;

  Item(
      {required this.name,
      required this.id,
      required this.broughtPrice,
      required this.sellingPrice,
      required this.quantity,
      required this.photoPath});

  factory Item.copy(Item original) {
    return Item(
        name: original.name,
        id: original.id,
        broughtPrice: original.broughtPrice,
        sellingPrice: original.sellingPrice,
        quantity: original.quantity,
        photoPath: original.photoPath);
  }

  factory Item.copyWithQuantity(Item original, int newQuantity) {
    return Item(
        name: original.name,
        id: original.id,
        broughtPrice: original.broughtPrice,
        sellingPrice: original.sellingPrice,
        quantity: newQuantity,
        photoPath: original.photoPath);
  }

  factory Item.copyWithAddedQuantity(Item original, int addedQuantity) {
    return Item(
        name: original.name,
        id: original.id,
        broughtPrice: original.broughtPrice,
        sellingPrice: original.sellingPrice,
        quantity: original.quantity + addedQuantity,
        photoPath: original.photoPath);
  }
}

class Receipt {
  final String customerName;
  final List<Item> broughtItems;
  final String creationDate;

  Receipt({
    required this.customerName,
    required this.broughtItems,
    required this.creationDate,
  });
}
