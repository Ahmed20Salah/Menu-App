import 'package:menu_app/models/item.dart';
import 'dart:convert';

class Order {
  int id;
  List<Item> items = [];
  double total = 0;
  int table = 1;
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'items': items.toString(), 'total': this.total};
  }
Order({table});
  addItem(Item item) {
    if (items.length > 0) {
      for (var it in items) {
        if (item.id != it.id) {
          items.add(item);
          total += item.price;
        }
      }
    } else {
      items.add(item);
      total += item.price;
    }
  }
}
