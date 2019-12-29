import 'package:flutter/material.dart';
import 'package:menu_app/data/db.dart';
import 'package:menu_app/models/item.dart';
import 'package:menu_app/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu',
      home: Home(),
      theme: ThemeData(canvasColor: Colors.black87),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Hi',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              child: Text('Try DB'),
              onPressed: () async {
                MenuDatabase db = MenuDatabase();
                Item item = Item.fromMap({
                  'name': 'burger',
                  'description': 'junky food',
                  'price': 20,
                  'category': 1
                });
                var res = await db.insertItem(item);
                print(res);
                var get = await db.getItems();
                print(get);
              },
            )
          ],
        ),
      ),
    );
  }
}
