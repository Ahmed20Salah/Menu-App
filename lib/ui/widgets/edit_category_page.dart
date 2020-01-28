import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/models/item.dart';
import 'package:menu_app/ui/widgets/add_category.dart';
import 'package:menu_app/ui/widgets/add_item.dart';

class EditCategory extends StatefulWidget {
  var data;
  EditCategory(this.data);
  @override
  State<StatefulWidget> createState() {
    return EditCategoryState();
  }
}

class EditCategoryState extends State<EditCategory> {
  List<Item> data = [
    Item.fromMap({
      'id': 1,
      'name': 'burger',
      'description': 'cheess with meat',
      'price': 40.0
    }),
    Item.fromMap({
      'id': 1,
      'name': 'burger',
      'description': 'cheess with meat',
      'price': 40.0
    }),
    Item.fromMap({
      'id': 1,
      'name': 'burger',
      'description': 'cheess with meat',
      'price': 40.0
    }),
    Item.fromMap({
      'id': 1,
      'name': 'burger',
      'description': 'cheess with meat',
      'price': 40.0
    }),
    Item.fromMap({
      'id': 1,
      'name': 'burger',
      'description': 'cheess with meat',
      'price': 40.0
    }),
  ];


  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: <Widget>[
              Text(
                widget.data.name,
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
              SizedBox(
                width: 40.0,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    child: SingleChildScrollView(
                        child: AlertDialog(
                      title: AddCategory(
                        cat: widget.data,
                        width: width,
                      ),
                    )),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'edit',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 40.0,
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.remove_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'remove',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )
                  ],
                ),
                onTap: () {
                  model.deleteCategory(widget.data).then((_) {
                    model.fetch();
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.data.items.length,
            itemBuilder: (BuildContext context, int index) {
              return _item(widget.data.items[index]);
            },
          ),
          height: 200.0,
        )
      ],
    );
  }

  Widget _item(Item item) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 210.0,
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // height: 200.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // InkWell(
                //   child: Icon(
                //     Icons.edit,
                //     color: Colors.white,
                //   ),
                //   onTap: () async {
                //     showDialog(
                //       context: context,
                //       child: SingleChildScrollView(
                //         child: AlertDialog(
                //           title: AddItem(
                //             data: item,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    print(item.id);
                    await model.deleteItem(item).then((_) {
                      model.fetch();
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            // height: 100.0,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Image.memory(
              base64Decode(item.image[0]),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      width: 120.0,
                      child: Text(
                        item.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Text(
                  '${item.price.toString()} SR',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
