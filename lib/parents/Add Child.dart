import 'package:autisma/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Navbar.dart';

String result = "";

class dice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Add Child'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: AddChild(),
    );
  }
}

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  late TextEditingController myController;
  @override
  void initState() {
    super.initState();
    loadResult();
  }

  loadResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      result = (prefs.getString("result"))!;
      myController = TextEditingController()..text = result;
    });
  }

  late String child_name = "";
  late String password = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Add Child'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
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
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      maxLength: 30,
                      onSaved: (value) => setState(() => child_name = value!),
                      decoration: InputDecoration(
                        labelText: 'Enter Child Name',
                      ),
                      onChanged: (value) {
                        child_name = value;
                      },
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'Enter at least 4 characters';
                        } else {
                          return null;
                        }
                      }),
                  TextFormField(
                    maxLength: 30,
                    enabled: false,
                    onSaved: (value) => setState(() => child_name = value!),
                    controller: myController,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.length < 7) {
                        return 'Password must be at least 7 characters long';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) => setState(() => password = value!),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: RoundedButton(
                title: 'Add Child',
                color: Colors.lightBlue,
                onpressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid)
                    _formKey.currentState!.save();
                  else
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Child Registered"),
                    ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
