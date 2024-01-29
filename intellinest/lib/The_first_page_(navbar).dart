import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intellinest/logins_screen.dart';
import 'package:intellinest/pages/home_page.dart';
import 'package:intellinest/pages/monitoring_page.dart';
import 'package:intellinest/pages/setting_page.dart';

class TheFirstPage extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TheFirstPage({super.key});
  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  State<TheFirstPage> createState() => _TheFirstPageState();
}

class _TheFirstPageState extends State<TheFirstPage> {
  int selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    MonitoringPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar:
          // HomePage(),
          BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_outlined),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.white70,
        elevation: 15,
        enableFeedback: true,
        unselectedItemColor: Colors.white30,
        currentIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
