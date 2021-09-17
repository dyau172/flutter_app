import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'Note',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
