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
  var width;
  AddItem({this.data, this.width});
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int category = 0;
  Uint8List _avatarImg;
  bool isEditing = false;
  String sendImage;
  bool error = false;
  bool catError = false;
  List<String> img=[];
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
        width: widget.width < 610
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 80 / 100,
        padding:
            EdgeInsets.symmetric(horizontal: widget.width < 610 ? 20.0 : 40.0),
        height: 710.0,
        child: Form(
          key: _formKey,
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
                      img.add(sendImage);
                      error = false;
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
              error
                  ? Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        'Must Pick a Picture !',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value.isEmpty) {
                      print('empty');
                      return 'This is Field can`t be Empty';
                    }
                  },
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
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      print('empty');
                      return 'This is Field can`t be Empty';
                    }
                  },
                  controller: _price,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                  keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[
                  //   WhitelistingTextInputFormatter.digitsOnly
                  // ],
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
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      print('empty');
                      return 'This is Field can`t be Empty';
                    }
                  },
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
              catError
                  ? Container(
                      margin: EdgeInsets.only(top: 4),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Must choose a Category !',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.width < 610 ? 20.0: 50.0, vertical:  widget.width < 610 ? 15:20.0),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Color(0xff80BB01),
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          if (sendImage == null || inialvalue == 'Category') {
                            error = true;
                            catError = true;
                          }
                          return;
                        }
                        if (sendImage == null || inialvalue == 'Category') {
                          error = true;
                          catError = true;
                        }
                        // saveImage(sendImage, id)
                        await model
                            .addItem(Item.fromMap({
                          'name': _name.text,
                          'description': _des.text,
                          'price': double.parse(_price.text),
                          'category': category,
                          'image': img
                        }))
                            .then((val) {
                          print(val);
                          model.fetch();
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.width < 610 ? 20.0:50.0, vertical: widget.width < 610 ? 15.0: 20.0),
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
      ),
    );
  }
}
