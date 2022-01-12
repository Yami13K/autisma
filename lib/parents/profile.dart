import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'Add Games/Add Game.dart';
import 'cards.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final imagePicker = ImagePicker();
  Future pickImage(ImageSource source) async {
    try {
      final image = await imagePicker.pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
    } on PlatformException catch (e) {
      print("Failed To Pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("DashBoard"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            ImageSplashCard(
              path: "images/boy.jpg",
            ),
            SizedBox(
              height: 20,
            ),
            ColoredCard(
              ontap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Games()));
              },
              color: Colors.redAccent,
              title: "Add Games:",
              text:
                  "Here, as a parent you can choose the game you'd like your son to play",
            ),
            _image == null ? Text("no Image is picked") : Image.file(_image!),
            SizedBox(
              height: 20,
            ),
            ColoredCard(
              ontap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Scores()));
              },
              color: Colors.teal[500],
              title: "Scores:",
              text:
                  "Here, as a parent you can display the scores of the games your son has been playing to monitor his performance",
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
}
