import 'package:flutter/material.dart';
import 'package:flutter_app/views/create_note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Flutter',
              style: TextStyle(fontSize: 28.0),
            ),
            Text(
              'App',
              style: TextStyle(fontSize: 28.0, color: Colors.purple),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.purple,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateNote()));
                },
                child: Icon(Icons.add),
              )
            ],
          )),
    );
  }
}
