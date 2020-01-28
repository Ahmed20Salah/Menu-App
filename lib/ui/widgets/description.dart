import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/models/item.dart';

class Description extends StatefulWidget {
  Item item;
  Description(this.item);
  @override
  State<StatefulWidget> createState() {
    return DescriptionState();
  }
}

class DescriptionState extends State<Description> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    print(widget.item.image.length);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Dark.png'), fit: BoxFit.cover),
        ),
        height: 400.0,
        width: 400.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 150.0,
              height: 100.0,
              child: Image.memory(
                Base64Decoder().convert(widget.item.image[0]),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100.0,
              child: ListView.builder(
                itemCount: widget.item.image.length - 1,
                itemBuilder: (context, index) {
                  return Container(
                    width: 75.0,
                    height: 75.0,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.memory(
                      Base64Decoder().convert(widget.item.image[index]),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.item.name,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 80.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                              ),
                              Text(
                                '$count',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  if (count > 1) {
                                    setState(() {
                                      count--;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.item.price.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.item.description,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              child: Container(
                width: 70.0,
                height: 25.0,
                color: Colors.green,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                if (count > 1) {
                  for (int i = 0; i < count; i++) {
                    model.addOrder(widget.item);
                  }
                  Navigator.pop(context);
                } else {
                  model.addOrder(widget.item);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
