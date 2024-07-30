import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../widgets/alert_box.dart';
import '../widgets/bottom_sheet_fan.dart';
import '../widgets/bottom_sheet_led.dart';
import '../widgets/sensor_widget.dart';
import '../widgets/switch_fan_box.dart';
import '../widgets/switch_led_box.dart';
import '../widgets/water_level_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int delay = 100;

  final DatabaseReference _temperatureRef =
      FirebaseDatabase.instance.ref('Sensors/Temperature');
  final DatabaseReference _humidityRef =
      FirebaseDatabase.instance.ref('Sensors/Humidity');
  final DatabaseReference _fireAlertRef =
      FirebaseDatabase.instance.ref('Sensors/fireAlert');
  final DatabaseReference _gasAlertRef =
      FirebaseDatabase.instance.ref('Sensors/gasAlert');
  final DatabaseReference _waterLevelAlertRef =
      FirebaseDatabase.instance.ref('Sensors/waterLevelAlert');

  int _temperature = 0;
  int _humidity = 0;
  bool _fireAlert = false;
  bool _gasAlert = false;
  bool _waterLevelAlert = false;
  bool _showOverlay = false;
  String _transcription = '';

  final AudioPlayer _audioPlayer = AudioPlayer();
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<void> _playAlertSound() async {
    await _audioPlayer.play(AssetSource('assets/alert_sound.mp3'));
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _showOverlay = true;
      });
      _speech.listen(
        onResult: (val) => setState(() {
          _transcription = val.recognizedWords;
        }),
      );
    }
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _showOverlay = false;
    });
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Initialize the plugin for notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('homelogo');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _initializeListeners();
  }

  void _initializeListeners() {
    _temperatureRef.onValue.listen((event) {
      final Object? value = event.snapshot.value;
      if (value != null) {
        setState(() {
          _temperature = int.tryParse(value.toString()) ?? 0;
        });
      }
    });

    _humidityRef.onValue.listen((event) {
      final Object? value = event.snapshot.value;
      if (value != null) {
        setState(() {
          _humidity = int.tryParse(value.toString()) ?? 0;
        });
      }
    });

    _fireAlertRef.onValue.listen((event) {
      final Object? value = event.snapshot.value;
      if (value != null) {
        setState(() {
          _fireAlert = value.toString() == '1';
          if (_fireAlert) {
            _playAlertSound();
            _showNotification('Fire Alert', 'Fire detected in the house!');
          }
        });
      }
    });

    _gasAlertRef.onValue.listen((event) {
      final Object? value = event.snapshot.value;
      if (value != null) {
        setState(() {
          _gasAlert = value.toString() == '1';
          if (_gasAlert) {
            _playAlertSound();
            _showNotification('Gas Alert', 'Gas leak detected in the house!');
          }
        });
      }
    });

    _waterLevelAlertRef.onValue.listen((event) {
      final Object? value = event.snapshot.value;
      if (value != null) {
        setState(() {
          _waterLevelAlert = value.toString() == '1';
          if (_waterLevelAlert) {
            _playAlertSound();
            _showNotification(
                'Water Level Alert', 'High water level detected!');
          }
        });
      }
    });
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('alert_channel', 'Alert Notifications',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          SafeArea(
                            child: FadeInUp(
                              delay: Duration(milliseconds: delay),
                              child: Text(
                                'Hello,',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.08,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          FadeInUp(
                            delay: Duration(milliseconds: delay),
                            child: Text(
                              'User',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image(
                        image: AssetImage(''),
                      ),
                    ],
                  ),
                  FadeInUp(
                    delay: Duration(milliseconds: delay),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 0, top: 15),
                      child: Text(
                        'W E L C O M E   T O   H O M E ',
                        style: TextStyle(color: Colors.white38),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeInUp(
                    delay: Duration(milliseconds: 2 * delay),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return LedBottomScreen();
                              },
                            );
                          },
                          child: SwitchLedBox(
                            transcription: _transcription,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return FanBottomScreen();
                              },
                            );
                          },
                          child: SwitchFanBox(
                            transcription: _transcription,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FadeInUp(
                        delay: Duration(milliseconds: 3 * delay),
                        child: TemperatureCard(
                            temperature: _temperature,
                            screenWidth: screenWidth),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: Duration(milliseconds: 4 * delay),
                        child: HumidityCard(
                            humidity: _humidity, screenWidth: screenWidth),
                      ),
                      // const SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(height: 15),
                  FadeInUp(
                    delay: Duration(milliseconds: 5 * delay),
                    child: AlertsWidget(
                      fireAlert: _fireAlert,
                      gasAlert: _gasAlert,
                      waterLevelAlert: _waterLevelAlert,
                      screenWidth: screenWidth,
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeInUp(
                    delay: Duration(milliseconds: 6 * delay),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: WaterLevelProgress(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showOverlay)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FadeInUp(
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      _transcription.isNotEmpty
                          ? _transcription
                          : 'Listening...',
                      // "Listening...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // setState(() {
      //     //   _showOverlay = !_showOverlay;
      //     // });
      //     if (_showOverlay) {
      //       _stopListening();
      //     } else {
      //       _startListening();
      //     }
      //   },
      //   child: Icon(Icons.mic),
      //   shape: CircleBorder(),
      //   backgroundColor: Colors.blueAccent,
      // ),
    );
  }
}
