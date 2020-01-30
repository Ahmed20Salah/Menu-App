import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/models/item.dart';

class Description extends StatefulWidget {
  final Item item;
  Description(this.item);
  @override
  State<StatefulWidget> createState() {
    return DescriptionState();
  }
}

class DescriptionState extends State<Description> {
  int count = 1;
  String image;
  bool _mode = false;
  int index = 0;

  @override
  void initState() {
    image = widget.item.image[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.item.image.length);
    return SingleChildScrollView(
      child: _mode
          ? Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width),
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          ),
                      child:
                          Image.memory(base64Decode(widget.item.image[index]))),
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      onPressed: () {
                        setState(() {
                          _mode = false;
                        });
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        index != 0
                            ?  IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                onPressed: () {
                                  if (index != 0) {
                                    setState(() {
                                      index--;
                                    });
                                  }
                                },
                              ) : Container(),
                        index < widget.item.image.length - 2
                            ? IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                onPressed: () {
                                  print('index = $index');
                                  print(widget.item.image.length);
                                  if (index < widget.item.image.length - 2) {
                                    setState(() {
                                      index++;
                                    });
                                  }
                                },
                              )
                            : Container(),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Dark.png'), fit: BoxFit.cover),
              ),
              // height: MediaQuery.of(context).size.height * 50 / 100,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(minWidth: 400.0, minHeight: 400.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _mode = true;
                      });
                    },
                    child: Container(
                      constraints:
                          BoxConstraints(maxHeight: 300.0, maxWidth: 300.0),
                      child: Image.memory(
                        Base64Decoder().convert(widget.item.image[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 120.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.item.image.length - 1,
                      itemBuilder: (context, nume) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          constraints:
                              BoxConstraints(maxHeight: 120.0, maxWidth: 100.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                this.image = image;
                                index = nume;
                              });
                            },
                            child: Image.memory(
                              base64Decode(widget.item.image[nume]),
                            ),
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
                                    color: Colors.white, fontSize: 24),
                              ),
                              Container(
                                width: 120.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      child: Container(
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.white,
                                          size: 35.0,
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
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    InkWell(
                                      child: Container(
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.white,
                                          size: 35.0,
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
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.item.description,
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Container(
                      width: 120.0,
                      height: 35.0,
                      color: Colors.green,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35,
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
