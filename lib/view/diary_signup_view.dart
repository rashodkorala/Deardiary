import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor:
            Colors.black, // Set the app bar background color to black
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors
                      .white, // Set the container background color to white
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    // Your logo or app name can go here
                    // Example: Image.asset('assets/logo.png'),

                    SizedBox(height: 20.0),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle:
                            TextStyle(color: Colors.black), // Text color
                      ),
                      style: TextStyle(color: Colors.black), // Text color
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(color: Colors.black), // Text color
                      ),
                      style: TextStyle(color: Colors.black), // Text color
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      obscureText: true, // For password input
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.black), // Text color
                      ),
                      style: TextStyle(color: Colors.black), // Text color
                    ),

                    SizedBox(height: 20.0),

                    ElevatedButton(
                      onPressed: () {
                        // Handle sign-up button press here
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .black, // Set button background color to black
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Make the button round
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            // Add a navigation route to the login page when "Log in" is clicked
                            Navigator.pushReplacementNamed(
                                context, '/loginView');
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.blue, // Highlighted text color
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
