import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'the_first_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return TheFirstPage();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TheFirstPage(),
          ),
        );
      } catch (e) {
        print("Error: $e");
        String errorMessage = 'An error occurred. Please try again later.';
        if (e is FirebaseAuthException) {
          if (e.code == 'wrong-password') {
            errorMessage = 'Incorrect password. Please try again.';
          } else if (e.code == 'user-not-found') {
            errorMessage = 'No user found with this email.';
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 30),
                        Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    if (isPortrait) ...[
                      Image.asset(
                        'icons/login.png',
                        height: mediaQuery.size.height * 0.3,
                      ),
                    ] else ...[
                      Image.asset(
                        'icons/login.png',
                        width: mediaQuery.size.width * 0.3,
                      ),
                    ],
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    // ElevatedButton(
                    //   onPressed: _signInWithEmailAndPassword,
                    //   style: ElevatedButton.styleFrom(
                    //     textStyle: const TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //     padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   ),
                    //   child: const Text('Login'),
                    // ),
                    GestureDetector(
                      onTap: _signInWithEmailAndPassword,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 50),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
