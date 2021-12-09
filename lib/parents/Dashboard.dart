import 'package:autisma/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';

class schedule extends StatefulWidget {
  const schedule({Key? key}) : super(key: key);

  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  late String child_name;
  late String text;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Child'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Your Kid Name',

                ),
                onChanged: (value) {
                  child_name = value;
                },
                validator: (value) =>
                value!.isEmpty ? 'You Must Enter A name' : null,
              ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              validator: (value) => value!.length <= 6
                  ? 'Your password must be larger than 6 characters'
                  : null,
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 55,
              width: 300,
              child: RoundedButton(
                title: 'Login',
                color: Colors.blueAccent,
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
