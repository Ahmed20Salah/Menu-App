import 'package:menu_app/models/item.dart';

class Category {
  int id;
  String name;
  List<Item> items = [];

  Category(this.id, this.name);
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    // map['items'] = this.items;
    return map;
  }

  addItem(Item item) {
    items.add(item);
  }
}
