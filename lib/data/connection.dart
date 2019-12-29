import 'dart:async';

import 'package:menu_app/data/db.dart';
import 'package:menu_app/models/category.dart';
import 'package:menu_app/models/item.dart';
import 'package:menu_app/models/order.dart';

class _DBConnection {
  MenuDatabase _db = MenuDatabase();

  List<Category> categories = [];
  List<String> catString = ['Category'];
  List<int> catId = [0];
  Order order;
  List<Order> allOrders = [];

// initalize all orders
  initializeAllOrders() {
    for (int i = 1; i < 6; i++) {
      allOrders.add(Order(table: i + 1));
    }
    order = allOrders[0];
  }

//
  switchfun(int number) {
    print(number);
    int found = 0;
    if (allOrders.length == 0) {
      allOrders.add(order);
      order = Order();
      order.table = number;
      print('first item added');
    } else {
      for (int i = 0; i < allOrders.length; i++) {
        if (order.table == allOrders[i].table) {
          print('founded and updated');
          allOrders[i] = order;
        } else {
          print('not found but added');
          allOrders.add(order);
        }
      }
      for (int i = 0; i < allOrders.length; i++) {
        if (allOrders[i].table == number) {
          print('the new one was there ');
          order = allOrders[i];
          found++;
        }
      }
    }
    if (found == 0) {
      print('the new one not found but added');
      order = Order();
      order.table = number;
    }
  }
  // switchFun() {
  //   print('switch fun');
  //   int updataExised = 0;
  //   if (allOrders.length == 0) {
  //     print('length = 0');
  //     // print(order.items.length);
  //     // print(order.table);
  //     allOrders.add(order);
  //   } else {
  //     for (int i = 0; i < allOrders.length; i++) {
  //       if (order.table == allOrders[i].table) {
  //         print('exised');
  //         updataExised++;
  //         print(updataExised);
  //       }
  //     }
  //     if (updataExised == 0) {
  //       print('not exised and added');
  //       allOrders.add(order);
  //     }
  //   }
  // }

  // getTable(int number) {
  //   print(' getTable $number');
  //   int found = 0;
  //   for (int i = 0; i < allOrders.length; i++) {
  //     if (allOrders[i].table == number +1) {
  //       found++;
  //       order = allOrders[i];
  //     }
  //   }
  //   if (found == 0) {
  //     order = Order();
  //     order.table = number +1;
  //     tableNum = order.table;
  //   }
  //   print(order.table);
  // }

  addCtegory(Map<String, dynamic> name) async {
    var re = await _db.insertCategory(name);
    if (re != null) {
      categories.add(Category(re, name['name']));
    }
    print(re);
  }

  addItem(Item item) async {
    var re = await _db.insertItem(item);
    if (re != null) {
      for (int j = 0; j < categories.length; j++) {
        if (item.category == categories[j].id) {
          print('added');
          categories[j].addItem(Item.fromMap(item.toMap()));
        }
      }
    }
  }

  StreamController cat = StreamController.broadcast();
  getCategories() async {
    var re = await _db.getCategory();
    print(re);
    re = re.toList();

    for (var item in re) {
      categories.add(Category(item['id'], item['name']));
    }
  }

  getCategorys() {
    for (int i = 0; i < categories.length; i++) {
      if (catString.length == 0) {
        catString.add(categories[i].name);
        catId.add((categories[i].id));
      } else {
        for (var item in catString) {
          if (item != categories[i].name) {
            catString.add(categories[i].name);
            catId.add((categories[i].id));
          }
        }
      }
    }
  }

  getItems() async {
    print('getItems');
    await _db.getItems().then((val) {
      print(val);

      for (int i = 0; i < val.length; i++) {
        for (int j = 0; j < categories.length; j++) {
          if (val[i]['category'] == categories[j].id) {
            categories[j].addItem(Item(
                id: val[i]['id'],
                name: val[i]['name'],
                description: val[i]['description'],
                price: val[i]['price'],
                category: val[i]['category'],
                image: val[i]['image']));
          }
        }
      }
    });
  }

  fetch() {
    cat.add(categories);
  }

  deleteItem(Item item) async {
    print('from connection id == ${item.id}');
    var re = await _db.deleteItem(item);
    print('from delete $re');
    for (int j = 0; j < categories.length; j++) {
      if (item.category == categories[j].id) {
        for (int i = 0; i < categories[j].items.length; i++) {
          if (item.id == categories[j].items[i].id) {
            print('deleted from ram');
            categories[j].items.removeAt(i);
          }
        }
      }
    }
  }

  deleteCategory(Category category) async {
    for (int i = 0; i < categories.length; i++) {
      if (category.id == categories[i].id) {
        categories.removeAt(i);
      }
    }
    for (int i = 0; i < category.items.length; i++) {
      deleteItem(category.items[i]);
    }

    var re = await _db.deleteCategory(category);
    print('deleted from Category $re');
  }

  editCategory(Category category) async {
    for (int i = 0; i < categories.length; i++) {
      if (category.id == categories[i].id) {
        categories[i] = category;
      }
    }
    await _db.editCategory(category);
  }

  editItem(Item item) async {
    var re = await _db.editItem(item);
    print(re);
    for (int i = 0; i < categories.length; i++) {
      if (item.category == categories[i].id) {
        for (int j = 0; j < categories[i].items.length; j++) {
          if (item.id == categories[i].items[j].id) {
            categories[i].items[j] = item;
          }
        }
      }
    }
  }

  addOrder(Item item) {
    order.items.add(item);
    order.total += item.price;
    for (int i = 0; i < allOrders.length; i++) {
      if (allOrders[i].table == order.table) {
        allOrders[i].items.add(item);
        allOrders[i].total += item.price;
      }
    }
  }

  checkOut(Order order) async {
    int table = order.table;
    // order = Order();
    // order.table = table;
    // print('item deleted');
    order.items.removeRange(0, order.items.length);
    order.total = 0.0;
    for (int i = 0; i < allOrders.length; i++) {
      if (allOrders[i].table == table) {
        allOrders[i] = order;
        print('deleted from all');
      }
    }
  }

  deleteOrder(Item item) {
    for (int i = 0; i < order.items.length; i++) {
      if (order.items[i].id == item.id) {
        order.items.removeAt(i);
        order.total -= item.price;
      }
    }
    for (int i = 0; i < allOrders.length; i++) {
      if (allOrders[i].table == order.table) {
        allOrders[i].items.removeAt(i);
        allOrders[i].total -= item.price;
      }
    }
  }

  // getOrders()async {
  //   var re = await _db.getOrders();
  //   for(int i =0 ; i < re.length; i++){
  //     var order = Order();
  //     order.id = re[i].id;
  //     order.items = re[i].items.toList<Order>();
  //     order.total = re[i].total;

  //     // history.add()
  //   }
  // }
}

_DBConnection model = _DBConnection();
