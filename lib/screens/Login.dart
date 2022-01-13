import 'package:autisma/parents/Add%20Child.dart';
import 'package:flutter/material.dart';
import 'package:autisma/widgets/RoundedButton.dart';


class LoginScreen  extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<LoginScreen> {
  late String username="";
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

                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
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
                      maxLength: 30,
                      onSaved: (value) => setState(() => username = value!),
                      decoration: InputDecoration(
                        labelText: 'Enter Your Name',
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
                title: 'Login',
                color: Colors.blueAccent,
                onpressed : ()  {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    _formKey.currentState!.save();
                  }
                  else
                  Navigator.push(context,MaterialPageRoute(builder: (_)=>AddChild()));
                },
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
              child: new Text("Don\'t Have An Account?",style: TextStyle(fontSize: 18, color: Colors.black54,),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}

