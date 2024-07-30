import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FanBottomScreen extends StatefulWidget {
  const FanBottomScreen({super.key});

  @override
  State<FanBottomScreen> createState() => _FanBottomScreenState();
}

class _FanBottomScreenState extends State<FanBottomScreen> {
  final dbR = FirebaseDatabase.instance.ref();
  int timerValue = 0; // Initial timer value in seconds
  bool timerRunning = false;
  bool isSwitchOn = false; // Add this variable

  void toggleBulb() {
    setState(() {
      isSwitchOn = !isSwitchOn;
      int valueToSet = isSwitchOn ? 1 : 0;
      dbR.child('Devices/Device 2').set(valueToSet);
      // dbR.child('Devices/Device 2').set({'Switch': valueToSet});
    });
  }

  void setTimer(int value) {
    setState(() {
      timerValue = value;
    });
  }

  void startCountdown() {
    setState(() {
      timerRunning = true;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timerValue > 0) {
          timerValue--;
        } else {
          isSwitchOn = !isSwitchOn;
          int valueToSet = isSwitchOn ? 1 : 0;
          dbR.child('Devices/Device 2').set(valueToSet);

          timer.cancel();
          timerRunning = false;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Listen for changes in the 'Pins/LED' value
    dbR.child('Devices/Device 2').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        // Update the switch state based on the received value
        setState(() {
          isSwitchOn = value == 1; // True if value is 1, false otherwise
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lamp Control',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Timer:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: timerRunning ? null : startCountdown,
                    icon: Icon(Icons.timer),
                    label: Text('Start'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Slider(
                value: timerValue.toDouble(),
                min: 0,
                max: 60,
                divisions: 60,
                onChanged: (value) {
                  setTimer(value.toInt());
                },
                label: '$timerValue',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$timerValue Seconds',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Fan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      Switch(
                        value: isSwitchOn,
                        onChanged: (value) {
                          toggleBulb(); // Toggle the switch state and update the database
                        },
                        activeColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
