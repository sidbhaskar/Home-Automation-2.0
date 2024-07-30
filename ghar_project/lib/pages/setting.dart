import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logins_screen.dart';

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
  final DatabaseReference firmwareAvailableRef =
      FirebaseDatabase.instance.ref('System/firmwareAvailable');
  final DatabaseReference firmwareCheckRef =
      FirebaseDatabase.instance.ref('System/firmwareCheck');
  final DatabaseReference updateConfirmationRef =
      FirebaseDatabase.instance.ref('System/updateConfirmation');

  bool firmwareAvailable = false;

  @override
  void initState() {
    super.initState();

    firmwareAvailableRef.onValue.listen(
      (event) {
        final Object? value = event.snapshot.value;
        if (value != null) {
          setState(() {
            firmwareAvailable = value as bool;
          });
        }
      },
    );
  }

  Future<void> _checkForUpdate() async {
    await firmwareCheckRef.set(true);

    // Fetch the latest firmwareAvailable value
    final firmwareAvailableSnapshot = await firmwareAvailableRef.once();
    final firmwareAvailableValue =
        firmwareAvailableSnapshot.snapshot.value as bool;

    if (firmwareAvailableValue) {
      _showUpdateDialog();
    } else {
      _showNoUpdateDialog();
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content:
              Text('An update is available. Would you like to install it now?'),
          actions: [
            TextButton(
              onPressed: () async {
                await updateConfirmationRef.set(true);
                Navigator.of(context).pop();
                // Add your update installation logic here if needed
              },
              child: Text('Install'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showNoUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Update Available'),
          content: Text('No updates are available at the moment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        // centerTitle: true,
        actions: [
          // Text('Signout'),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            onPressed: () {
              widget._signOut(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'IntelliNest',
                      style: GoogleFonts.poppins(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 139, 177, 243),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Smart Home Automation System',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkForUpdate,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Check for new version',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Made with ❤️ by Siddharth Bhaskar',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
