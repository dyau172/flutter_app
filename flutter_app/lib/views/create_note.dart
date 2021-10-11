import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  File? selectedImage;
  final picker = ImagePicker();

  bool _isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future<void> uploadNote() async {
    if (selectedImage != null) {
      //upload image
      setState(() {
        _isLoading = true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("noteImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Image Error");
        }

        print(imageUrl);
      });

      Map<String, dynamic> noteData = {
        "authorName": authorTextEditingController.text,
        "title": titleTextEditingController.text,
        "desc": descTextEditingController.text
      };

      crudMethods.addData(noteData).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    } else {}
  }

  TextEditingController titleTextEditingController =
      new TextEditingController();
  TextEditingController authorTextEditingController =
      new TextEditingController();
  TextEditingController descTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
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
        actions: [
          GestureDetector(
            onTap: () {
              uploadNote();
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImage != null
                            ? Container(
                                height: 150,
                                margin: EdgeInsets.symmetric(vertical: 24),
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                margin: EdgeInsets.symmetric(vertical: 24),
                                width: MediaQuery.of(context).size.width,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(hintText: "enter title"),
                      ),
                      TextField(
                        controller: descTextEditingController,
                        decoration: InputDecoration(hintText: "enter desc"),
                      ),
                      TextField(
                        controller: authorTextEditingController,
                        decoration:
                            InputDecoration(hintText: "enter author name"),
                      ),
                    ],
                  )),
            ),
    );
  }
}
