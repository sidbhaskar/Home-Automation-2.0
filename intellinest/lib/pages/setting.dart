import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellinest/logins_screen.dart';

class SettingsPage extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SettingsPage({super.key});
  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Logging Out ?',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Image.asset(
            'icons/logout.png',
            height: 390,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () => widget._signOut(context),
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              padding: const EdgeInsets.only(left: 30, right: 30),
            ),
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
