import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/data/connection.dart';
import 'package:menu_app/models/category.dart';

class AddCategory extends StatefulWidget {
  Category cat;
  double width;
  AddCategory({this.cat, this.width});
  @override
  State<StatefulWidget> createState() {
    return AddCategoryState();
  }
}

class AddCategoryState extends State<AddCategory> {
  bool isEditing = false;

  TextEditingController _category = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.cat != null) {
      isEditing = true;
      _category.text = widget.cat.name;
    }
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Dark.png'), fit: BoxFit.cover),
            border: Border.all(color: Colors.white)),
        width: MediaQuery.of(context).size.width * 80 / 100,
        height: 600.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
              ),
              width: MediaQuery.of(context).size.width * 60 / 100,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      print('empty');
                      return 'Name is required and should be 5+ characters long.';
                    }
                    // print('not empty');
                    // return '';
                  },
                  controller: _category,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: InputBorder.none,
                      hintText: 'Category Name',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 60 / 100,
              // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.width < 610 ? 20.0 : 50.0,
                        vertical: widget.width < 610 ? 15.0 : 20.0),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Color(0xff80BB01),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      if (isEditing) {
                        widget.cat.name = _category.text;
                        await model.editCategory(widget.cat);
                        Navigator.pop(context);
                      } else {
                        await model.addCtegory(
                            {'id': null, 'name': _category.text}).then((val) {
                          model.fetch();
                        });
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.width < 610 ? 20.0 : 50.0,
                        vertical: widget.width < 610 ? 15.0 : 20.0),
                    child: Text(
                      'Cancle',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Color(0xff80BB01),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
