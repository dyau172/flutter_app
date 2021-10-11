import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/crud.dart';
import 'package:flutter_app/views/create_note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();

  late QuerySnapshot noteSnapshot;

  @override
  void initState() {
    crudMethods.getData().then((result) {
      noteSnapshot = result;
      setState(() {});
    });
    super.initState();
  }

  Widget notesList() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 24),
        itemCount: noteSnapshot.docs.length,
        itemBuilder: (context, index) {
          return NoteTile(
            author: noteSnapshot.docs[index].get('author'),
            title: noteSnapshot.docs[index].get('title'),
            desc: noteSnapshot.docs[index].get('desc'),
            imgUrl: noteSnapshot.docs[index].get('imgUrl'),
          );
        },
      ),
    );
  }

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
      body: Container(
          child: noteSnapshot != null
              ? notesList()
              : Container(
                  child: Center(
                  child: CircularProgressIndicator(),
                  //child: Text('data'),
                ))),
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

class NoteTile extends StatelessWidget {
  final String imgUrl, title, desc, author;
  NoteTile(
      {required this.author,
      required this.desc,
      required this.imgUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 2),
          Text(
            '$desc - By $author',
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
