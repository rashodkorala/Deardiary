import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String fullName = '';
  String email = '';
  String password = '';

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Sign-up was successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, '/loginView');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    // Your logo or app name can go here
                    // Example: Image.asset('assets/logo.png'),

                    SizedBox(height: 20.0),

                    TextField(
                      onChanged: (value) {
                        fullName = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),

                    SizedBox(height: 20.0),

                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          // Show a success dialog
                          showSuccessDialog();
                        } catch (e) {
                          print(e.toString());
                          // Handle sign-up error
                        }
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/loginView');
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
