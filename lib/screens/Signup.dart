import 'package:autisma/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';



class RegistrationScreen  extends StatefulWidget {
  const RegistrationScreen ({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String username="";
  late String email="";
  late String password="";
  final _formKey = GlobalKey<FormState>();
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
                        'Hello!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'images/logo.png',
                          height: 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your username',
                        hintText: 'UserName',
                      ),
                      onChanged: (value) {
                        username = value;
                      },
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'Enter at least 4 characters';
                        } else {
                          return null;
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      hintText: 'Email',
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
                      final regExp = RegExp(pattern);

                      if (value!.isEmpty) {
                        return 'Enter an email';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => setState(() => email = value!),
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
                title: 'Register',
                color: Colors.blueAccent,
                onpressed : ()  {
                  final isValid = _formKey.currentState!.validate();
                },
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
              child: new Text("Already Have An Account? Sign In here",
                style: TextStyle(fontSize: 18, color: Colors.black54),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}

