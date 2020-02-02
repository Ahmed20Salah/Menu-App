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
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                        maxWidth: MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        ),
                    child: Image.memory(
                      base64Decode(widget.item.image[index]),
                    ),
                  ),
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
                            ? IconButton(
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
                              )
                            : Container(),
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
              width: MediaQuery.of(context).size.width * 70 / 100,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Dark.png'), fit: BoxFit.cover),
              ),
              // height: MediaQuery.of(context).size.height * 50 / 100,
              constraints: BoxConstraints(minWidth: 400.0, minHeight: 400.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        setState(() {
                          _mode = true;
                        });
                      },
                      child: Center(
                        child: Container(
                          constraints:
                              BoxConstraints(maxHeight: 300.0, maxWidth: 300.0),
                          child: Image.memory(
                            Base64Decoder().convert(widget.item.image[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 120.0,
                      width: MediaQuery.of(context).size.width * 50 / 100.0,
                      constraints: BoxConstraints(maxWidth: 400.0),
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.item.image.length - 1,
                          itemBuilder: (context, nume) {
                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              constraints: BoxConstraints(
                                  maxHeight: 120.0, maxWidth: 100.0),
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
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 250.0),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      ' ${widget.item.name}',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    Text(
                                      ':الاسم',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      ' ${widget.item.price}',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ),
                                    Text(
                                      ':السعر',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                   Container(
                                     constraints: BoxConstraints(maxWidth:300.0),
                                     
                                     child:Text(
                                      ' ${widget.item.description}',
                                      textDirection: TextDirection.rtl,
                                      softWrap: true,
                                      maxLines: 4,

                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
                                    ), ) ,
                                    Text(
                                      ':الوصف',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 140.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (count > 1) {
                                count--;
                              }
                            });
                          },
                        ),
                        Text(
                          count.toString(),
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,
                              size: 35, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                        ),
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
                  ),
                ],
              ),
            ),
    );
  }
}
