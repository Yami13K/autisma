import 'dart:convert';
import 'package:autisma/parents/Navbar.dart';
import 'package:autisma/parents/recorder/models/sound_player.dart';
import 'package:autisma/parents/recorder/models/sound_recorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as paths;

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? _image;
  final imagePicker = ImagePicker();
  final recorder = SoundRecorder();
  final player = SoundPlayer();
  late String path = "";

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
      final appDir = await getApplicationDocumentsDirectory();
      String fileName = paths.basename(image!.path);
      print(fileName);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
        path = image.path;
        print(image.path);
      });
    } on PlatformException catch (e) {
      print("Failed To Pick image: $e");
    }
  }

  Future<void> uploadImage() async {
    String uploadurl = "url";
    try {
      List<int> imageBytes = _image!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(Uri.parse(uploadurl), body: {
        'image': baseimage,
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata["error"]) {
          //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        } else {
          print("Upload successful");
        }
      } else {
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    } catch (e) {
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        chooseImage(),
                        _image == null ? Container() : upload()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            _image != null
                ? Container(
                    child: SizedBox(height: 150, child: Image.file(_image!)),
                  )
                : Container(),
            Text(path),
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

  ElevatedButton chooseImage() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(120, 50),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      icon: Icon(Icons.camera),
      label: Text(
        "Pick Image",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Choose Method'),
            content: const Text('Upload Either Using camera or gallery'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  this.pickImage(ImageSource.camera);
                },
                child: const Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  this.pickImage(ImageSource.gallery);
                },
                child: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton upload() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(120, 50),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      icon: Icon(Icons.arrow_upward_rounded),
      label: Text(
        "Upload Image",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        uploadImage();
      },
    );
  }
}
