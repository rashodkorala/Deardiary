import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isRegisterHereFocused = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<void> signInUser() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // User is logged in, navigate to the diary_log_view.dart view
        Navigator.pushReplacementNamed(context, '/diaryLogView');
      } else {
        // Handle login failure
      }
    } catch (e) {
      print(e.toString());
      // Handle login error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  color: const Color.fromARGB(255, 255, 255, 255),
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
                        email = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username or Email',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),

                    SizedBox(height: 20.0),

                    ElevatedButton(
                      onPressed: () {
                        signInUser(); // Call the function to handle the login
                      },
                      child: Text('Login'),
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
                        Text("Don't have an account?"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isRegisterHereFocused = hasFocus;
                            });
                          },
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signupView');
                            },
                            child: Text(
                              'Register here',
                              style: TextStyle(
                                color: isRegisterHereFocused
                                    ? Colors.blue
                                    : Colors.blue,
                                decoration: isRegisterHereFocused
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotPasswordView');
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
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
