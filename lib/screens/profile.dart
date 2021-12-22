import 'package:autisma/parents/recorder/recorder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../parents/cards.dart';
import 'dart:io';

import 'Add Games/Add Game.dart';

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
            Card(
              color: Colors.teal,
              shadowColor: Colors.red,
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Pictures And recorder",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      " Using this service you're going to be able to record your voice saying your name and upload a picture of you "
                      "sou the child can memorise the name of the family members more",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.camera,
                            size: 24.0,
                            color: Colors.black,
                          ),
                          label: Text('Upload Image'),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Choose Method'),
                              content: const Text(
                                  'Upload Either Using camera or gallery'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      pickImage(ImageSource.camera),
                                  child: const Text('Camera'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      pickImage(ImageSource.gallery),
                                  child: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.mic,
                            color: Colors.pink,
                            size: 24.0,
                          ),
                          label: Text('Record audio'),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Recorder()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
