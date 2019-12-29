import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/models/item.dart';
import 'dart:convert';
import 'dart:typed_data';

class AddItem extends StatefulWidget {
  var data;
  AddItem({this.data});
  @override
  State<StatefulWidget> createState() {
    return AddItemState();
  }
}

class AddItemState extends State<AddItem> {
  String inialvalue = 'Category';
  TextEditingController _name = TextEditingController();

  TextEditingController _price = TextEditingController();

  TextEditingController _des = TextEditingController();
  int category = 0;
  Uint8List _avatarImg;
  bool isEditing = false;
  String sendImage;
  @override
  void initState() {
    // model.getCategorys();
    super.initState();
  }

  // saveImage(String image, String name) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString(name, image);
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      isEditing = true;
      _avatarImg = base64Decode(widget.data.image);
      _name.text = widget.data.name;
      _price.text = widget.data.price.toString();
      _des.text = widget.data.description;
      category = widget.data.category;
      inialvalue = model.catString[model.catId.indexOf(widget.data.category)];
    }
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            image: DecorationImage(
                image: AssetImage('assets/Dark.png'), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width * 80 / 100,
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        height: 700.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              child:
                  _avatarImg == null ? Container() : Image.memory(_avatarImg),
            ),
            RaisedButton(
              onPressed: () async {
                ImagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 400.0,
                  maxHeight: 400.0,
                ).then((File image) {
                  setState(() {
                    sendImage = base64Encode(image.readAsBytesSync());
                    print(image.readAsBytesSync().length);
                    print(sendImage.length);
                    _avatarImg = base64Decode(sendImage);
                  });
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Text(
                'Upload',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              color: Color(0xff80BB01),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: TextField(
                controller: _name,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: InputBorder.none,
                    hintText: 'Item Name',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: TextField(
                controller: _price,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: InputBorder.none,
                    hintText: 'Price',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: TextField(
                controller: _des,
                maxLines: 3,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    border: InputBorder.none,
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButton(
                  underline: Container(),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      inialvalue = value;

                      category = model.catId[model.catString.indexOf(value)];
                    });
                  },
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  value: inialvalue,
                  items: model.catString.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Container(
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
            Container(
              width: MediaQuery.of(context).size.width ,
              padding: EdgeInsets.symmetric( vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Color(0xff80BB01),
                    onPressed: () async {
                      // saveImage(sendImage, id)
                      await model
                          .addItem(Item.fromMap({
                        'name': _name.text,
                        'description': _des.text,
                        'price': int.parse(_price.text),
                        'category': category,
                        'image': sendImage
                      }))
                          .then((val) {
                        print(val);
                        model.fetch();
                        Navigator.pop(context);
                      });
                    },
                  ),
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                    child: Text(
                      'Cancle',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Color(0xff80BB01),
                    onPressed: () {
                      isEditing = true;
                      _avatarImg = null;
                      _name.text = null;
                      _price.text = null;
                      _des.text = null;
                      category = null;
                      inialvalue = null;
                      widget.data = null;
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
