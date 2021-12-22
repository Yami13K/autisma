import 'package:autisma/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';

class AddChild extends StatefulWidget {
  const AddChild({Key? key}) : super(key: key);

  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  late String child_name;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,

                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 65),
                      Text(
                        'Add Child',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'images/autism.png',
                          height: 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Child Name',

              ),
              onChanged: (value) {
               child_name = value;
              },
              validator: (value) =>
              value!.isEmpty ? 'You must enter a name' : null,
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: RoundedButton(
                title: 'Add Child',
                color: Colors.teal,
                onpressed : ()  {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
