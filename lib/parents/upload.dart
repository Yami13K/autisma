import 'package:autisma/parents/Navbar.dart';
import 'package:autisma/parents/recorder/models/sound_player.dart';
import 'package:autisma/parents/recorder/models/sound_recorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? _image;
  final imagePicker = ImagePicker();
  final recorder = SoundRecorder();
  final player = SoundPlayer();
  String path = "";
  @override
  void initState() {
    // TODO: implement initState

    recorder.init();
    player.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    recorder.dispose();
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await imagePicker.pickImage(source: source);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
        path = image.path;
      });
    } on PlatformException catch (e) {
      print("Failed To Pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Upload "),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Choose Method'),
                  content: const Text('Upload Either Using camera or gallery'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        pickImage(ImageSource.camera);
                      },
                      child: const Text('Camera'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        pickImage(ImageSource.gallery);
                      },
                      child: const Text('Gallery'),
                    ),
                  ],
                ),
              ),
              child: Card(
                color: Colors.lightBlueAccent,
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
                        "Upload Image",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        " Here you can upload your family photos with voice messages recorded from the card below",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              color: Colors.lightBlueAccent,
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
                      "Record Audio",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RecordButton(),
                        PlayButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _image != null ? Image.file(_image!) : Container(),
            Text('Path = $path')
          ],
        ),
      );

  ElevatedButton RecordButton() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'Stop' : 'Start';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(120, 50), primary: primary, onPrimary: onPrimary),
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        await recorder.toggleRecorder();
        setState(() {});
      },
    );
  }

  ElevatedButton PlayButton() {
    final isPlaying = player.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'Stop Playing' : 'Play Recording';
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(120, 50),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        await player.togglePlayer(whenfinished: () => setState(() {}));
        setState(() {});
      },
    );
  }
}
