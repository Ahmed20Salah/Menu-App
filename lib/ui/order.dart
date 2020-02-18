import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';

class OrderPage extends StatefulWidget {
  @override
  createState() {
    return OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Dark.png'), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'Finish Order',
                      style: TextStyle(
                          color: Colors.white, fontSize: width < 550 ? 14 : 28),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text('Table ${model.order.table}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width < 550 ? 14 : 45,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width < 550 ? 20 : 40.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400.0,
                    child: ListView.builder(
                      itemCount: model.order.items.length,
                      itemBuilder: (context, index) {
                        return Stack(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                      size: width < 600 ? 22 : 40.0,
                                    ),
                                    onTap: () {
                                      model.deleteOrder(
                                          model.order.items[index]);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Container(
                                  height: width < 600 ? 60 : 100.0,
                                  width: width < 600 ? 60 : 100.0,
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Image.memory(
                                    base64Decode(
                                        model.order.items[index].image[0]),
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                                SizedBox(
                                  width: width < 610 ? 20 : 40.0,
                                ),
                                Container(
                                  // margin: EdgeInsets.only(right: 160.0),
                                  // padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2.0)),
                                  // width: MediaQuery.of(context).size.width-300.0,
                                  height: width < 550 ? 60 : 100.0,
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(width < 550 ? 10 : 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: width < 550 ? 60 : 80.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  model.order.items[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width < 550
                                                          ? 15
                                                          : 22),
                                                ),
                                                width: width < 550 ? 60 : 130.0,
                                              ),
                                              width < 550
                                                  ? Container()
                                                  : SizedBox(
                                                      height: 5.0,
                                                    ),
                                              Container(
                                                width:
                                                    width < 550 ? 130 : 160.0,
                                                child: Text(
                                                  model.order.items[index]
                                                      .description,
                                                  // softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width < 550
                                                          ? 15
                                                          : 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${model.order.items[index].price} SR',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    width < 550 ? 15 : 27),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]);
                      },
                    ),
                  ),
                  model.order.total == 0
                      ? Container()
                      : Container(
                          // alignment: Alignment.centerLeft,
                          child: Text(
                            'Total = ${model.order.total} SR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width < 550 ? 15 : 28),
                          ),
                        ),
                  model.order.items.length == 0
                      ? Container()
                      : InkWell(
                          onTap: () {
                            if (model.order.items.length == 0) {
                              return;
                            }
                            model.checkOut(model.order);
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 30.0),
                            width: width < 550 ? 120 : 360.0,
                            height: width < 550 ? 60 : 100.0,
                            color: Colors.green,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: width < 550 ? 15 : 42,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
