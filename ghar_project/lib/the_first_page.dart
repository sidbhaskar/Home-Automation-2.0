import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/monitoring_page.dart';
import 'pages/setting.dart';
// import 'package:intellinest/widgets/speech_recognizer.dart';

class TheFirstPage extends StatefulWidget {
  const TheFirstPage({super.key});

  @override
  State<TheFirstPage> createState() => _TheFirstPageState();
}

class _TheFirstPageState extends State<TheFirstPage> {
  int selectedPage = 0;

  final _pageOptions = [
    const HomePage(),
    // SpeechToTextPage(),
    // const MonitoringPage(),
    SettingsPage(),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.monitor_outlined),
          //   label: 'Monitoring',
          // ),
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
