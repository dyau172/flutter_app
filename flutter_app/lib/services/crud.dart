import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(noteData) async {
    print(noteData);
    FirebaseFirestore.instance
        .collection("notes")
        .add(noteData)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("notes").get();
  }

  deleteData() async {
    return FirebaseFirestore.instance.doc("documentId").delete();
  }
}
