import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/ui/home.dart';
import 'package:menu_app/ui/widgets/add_category.dart';
import 'package:menu_app/ui/widgets/add_item.dart';
import 'package:menu_app/ui/widgets/edit_category_page.dart';
import 'package:path/path.dart';

class Edit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditState();
  }
}

class EditState extends State<Edit> {
  List<String> values = ['Table 1', 'Table 2', 'Table 3', 'Table 4', 'Table 5'];

  var inialvalue = 'Table 1';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Dark.png'), fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      child: Text('Table ${model.order.table}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width < 610 ? 15 : 28,
                          )),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Container(
                              width:
                                  MediaQuery.of(context).size.width * 80 / 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Dark.png'),
                                      fit: BoxFit.cover)),
                              child: DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      inialvalue = value;
                                      model
                                          .switchfun(values.indexOf(value) + 1);
                                    });
                                  },
                                  style: TextStyle(fontSize: 20.0),
                                  value: inialvalue,
                                  items: values.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ));
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            size: width < 610 ? 22 : 35.0,
                            color: Colors.white,
                          ),
                          width < 610
                              ? Container()
                              : SizedBox(
                                  width: 10,
                                ),
                          Text(
                            'Home',
                            style: TextStyle(
                                fontSize: width < 610 ? 15 : 22,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            backgroundColor: Colors.transparent,
                            title: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/Dark.png'),
                                        fit: BoxFit.cover)),
                                height: 400.0,
                                width: width < 610
                                    ? MediaQuery.of(context).size.width
                                    : 600.0,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width < 610 ? 10.0 : 100.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            child: SingleChildScrollView(
                                              child: AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                title: AddItem(width:width),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 15),
                                          width: 400.0,
                                          color: Color(0xff80BB01),
                                          child: Text(
                                            'Add Item',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            child: SingleChildScrollView(
                                              child: AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                title: AddCategory(width: width),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 15),
                                          width: 400.0,
                                          color: Color(0xff80BB01),
                                          child: Text(
                                            'Add Category',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ])),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 3, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Icon(
                                Icons.add,
                                size: width < 610 ? 15 : 30.0,
                                color: Colors.white,
                              )),
                          width < 610
                              ? Container()
                              : SizedBox(
                                  width: 10,
                                ),
                          Text('Add item or category',
                              style: TextStyle(
                                fontSize: width < 610 ? 15 : 22,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height -100.0,
                child: StreamBuilder(
                  stream: model.cat.stream,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: model.categories.length,
                      itemBuilder: (context, index) {
                        return EditCategory(model.categories[index]);
                      },
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
