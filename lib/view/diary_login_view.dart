import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isRegisterHereFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  color: const Color.fromARGB(255, 255, 255,
                      255), // Set the container background color to black
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
                        labelText: 'Username or Email',
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(
                                255, 0, 0, 0)), // Text color
                      ),
                      style: TextStyle(
                          color:
                              const Color.fromARGB(255, 0, 0, 0)), // Text color
                    ),

                    SizedBox(height: 10.0),

                    TextField(
                      obscureText: true, // For password input
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(
                                255, 0, 0, 0)), // Text color
                      ),
                      style: TextStyle(
                          color:
                              const Color.fromARGB(255, 0, 0, 0)), // Text color
                    ),

                    SizedBox(height: 20.0),

                    ElevatedButton(
                      onPressed: () {
                        // Handle login button press here
                      },
                      child: Text('Login'),
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
                        Text("Don't have an account?"),
                        Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isRegisterHereFocused = hasFocus;
                            });
                          },
                          child: TextButton(
                            onPressed: () {
                              // Add a navigation route to the registration page when "Register here" is clicked
                              Navigator.pushNamed(context, '/signupView');
                            },
                            child: Text(
                              'Register here',
                              style: TextStyle(
                                color: isRegisterHereFocused
                                    ? Colors
                                        .blue // Highlighted text color when focused
                                    : Colors.blue, // Regular text color
                                decoration: isRegisterHereFocused
                                    ? TextDecoration
                                        .underline // Underline when focused
                                    : TextDecoration
                                        .none, // No underline when not focused
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        // Add a navigation route to reset password page
                        Navigator.pushNamed(context, '/forgotPasswordView');
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)), // Text color
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
