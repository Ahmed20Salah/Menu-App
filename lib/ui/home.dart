import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/models/category.dart';
import 'package:menu_app/models/order.dart';
import 'package:menu_app/ui/edit.dart';
import 'package:menu_app/ui/order.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  Category currentCategroy;
  @override
  void initState() {
    print('init');
    // print(model.categories);
    model.initializeAllOrders();
    if (model.categories.isEmpty) {
      model.getCategories();

      model.getItems().then((val) {
        model.getCategorys();
        model.fetch();
        if (model.categories.isEmpty) {
          currentCategroy = null;
        } else {
          currentCategroy = model.categories[0];
        }
      });
    } else {
      model.fetch();
      currentCategroy = model.categories[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double menuwidth = width * 30 / 100;
    int itemsCount = 3;
    double raito = 1;
    print(width);
    // print(MediaQuery.of(context).size.height);
    if (width < 610) {
      itemsCount = 1;
      raito = 1.4;
      print(width);
    } else if (width < 770) {
      itemsCount = 2;
      raito = .8;
    } else if (width < 970) {
      itemsCount = 2;
      raito = 1;
    } else if (width < 1040) {
      itemsCount = 2;
      raito = 1.1;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Dark.png'), fit: BoxFit.cover),
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(225, 225, 225, .2),
                padding: EdgeInsets.symmetric(vertical: 20.0),
                width: menuwidth,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    createLogoView(menuwidth - 50),
                    Container(
                      height: MediaQuery.of(context).size.height - menuwidth,
                      child: StreamBuilder(
                        stream: model.cat.stream,
                        builder: (context, snapshot) {
                          return currentCategroy == null
                              ? Container()
                              : createCategoryListView();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  color: Colors.black12,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Text(
                                'Table ${model.order.table}  ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width *
                                    45 /
                                    100,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                                size: 40.0,
                                              ),
                                              Text('Setting',
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              child: SingleChildScrollView(
                                                child: AlertDialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  title: Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/Dark.png'),
                                                            fit: BoxFit.cover),
                                                        border: Border.all(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width <
                                                            1080
                                                        ? MediaQuery.of(context)
                                                            .size
                                                            .width
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            500.0,
                                                    padding:
                                                        EdgeInsets.all(50.0),
                                                    child: Form(
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                            'Login',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 30.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 40.0,
                                                          ),
                                                          Container(
                                                            width: 300.0,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: TextField(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              controller:
                                                                  _controllerUsername,
                                                              decoration: InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              4),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                  hintText:
                                                                      'username'),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 20.0),
                                                            width: 300.0,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: TextField(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              controller:
                                                                  _controllerPassword,
                                                              decoration: InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              4),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                  hintText:
                                                                      'password'),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 20.0),
                                                            child: RaisedButton(
                                                              onPressed: () {
                                                                if (_controllerUsername
                                                                            .text ==
                                                                        'admin' &&
                                                                    _controllerPassword
                                                                            .text ==
                                                                        '123456') {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Edit()));
                                                                }
                                                              },
                                                              child:
                                                                  Text('Login'),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderPage()));
                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 40.0,
                                              ),
                                              Text('My Order',
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height < 600
                              ? MediaQuery.of(context).size.height - 120.0
                              : MediaQuery.of(context).size.height - 300.0,
                          width: MediaQuery.of(context).size.width * 60 / 100,
                          child: StreamBuilder(
                              stream: model.cat.stream,
                              builder: (context, snapshot) {
                                return currentCategroy == null
                                    ? Container()
                                    : GridView.builder(
                                        itemCount: currentCategroy.items.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: itemsCount,
                                                crossAxisSpacing: 20.0,
                                                childAspectRatio: raito),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              model.addOrder(
                                                  currentCategroy.items[index]);
                                              final snackBar = SnackBar(
                                                content: Text('Item Added'),
                                              );

                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              margin:
                                                  EdgeInsets.only(bottom: 20.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 130.0,
                                                    margin: EdgeInsets.only(
                                                        top: 30.0),
                                                    child: Image.memory(
                                                      Base64Decoder().convert(
                                                          currentCategroy
                                                              .items[index]
                                                              .image),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                currentCategroy
                                                                    .items[
                                                                        index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                currentCategroy
                                                                    .items[
                                                                        index]
                                                                    .description,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            currentCategroy
                                                                .items[index]
                                                                .price
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 32),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                              }))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget createLogoView(size) {
    return Container(
      width: size,
      height: size,
      child: Image.asset('assets/logo.jpeg', fit: BoxFit.cover),
    );
  }

  Widget createCategoryListView() {
    return Container(
      child: ListView.builder(
        itemCount: model.categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(model.categories[index].items);
              setState(() {
                currentCategroy = model.categories[index];
              });
            },
            child: Container(
              color: currentCategroy.id == model.categories[index].id
                  ? Color(0xff80BB01)
                  : Colors.transparent,
              alignment: Alignment.center,
              height: 70.0,
              width: MediaQuery.of(context).size.width,
              child: Text(
                model.categories[index].name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
