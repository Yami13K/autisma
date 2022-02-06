import 'dart:io';
import 'package:autisma/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String result = "";
  File? _image;
  final imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    loadResult();
  }

  loadResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      result = (prefs.getString("result"))!;
    });
  }

  test() async {
    //test the autisic children and the value is put in result and send via shared
    //preferences in the app's cache and accsessed in the add child page
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      result = "Autistic";
    });
    prefs.setString("result", result);
  }

  Future pickImage() async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
      if (_image != null) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Result:'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(result),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      }
    } on PlatformException catch (e) {
      print("Failed To Pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Text(
                'Welcome To Autismile',
                style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'MonteCarlo',
                    letterSpacing: 1.2),
              ),
              SizedBox(
                height: 80,
              ),
              Hero(
                tag: 'logoAnimation',
                child: Image.asset(
                  'images/boy.png',
                  fit: BoxFit.cover,
                  height: 300,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: RoundedButton(
                    color: Colors.white54,
                    title: 'detection',
                    onpressed: () {
                      // Navigator.of(context).pushNamed('mathmetical');
                      test();
                      pickImage();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: RoundedButton(
                    color: Colors.white54,
                    title: 'Proceed',
                    onpressed: () {
                      Navigator.of(context).pushNamed('login');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class result extends ChangeNotifier {}
