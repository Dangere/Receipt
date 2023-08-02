class Item {
  String name;
  int id;
  int broughtPrice;
  int sellingPrice;
  int quantity;
  String photoPath;

  Item(
      {required this.name,
      required this.id,
      required this.broughtPrice,
      required this.sellingPrice,
      required this.quantity,
      required this.photoPath});
}

class Receipt {
  String customerName;
  List<Item> broughtItems;
  String creationDate;

  Receipt({
    required this.customerName,
    required this.broughtItems,
    required this.creationDate,
  });
}
