import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SensorsTile extends StatefulWidget {
  // final String text;
  SensorsTile({
    super.key,
  });

  @override
  State<SensorsTile> createState() => _SensorsTileState();
}

class _SensorsTileState extends State<SensorsTile> {
  final dbR = FirebaseDatabase.instance.ref();
  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the 'Pins/LED' value
    dbR.child('Sensor Alert/Fire').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        // Update the switch state based on the received value
        setState(() {
          isSwitchOn = value == 1; // True if value is 1, false otherwise
        });
      }
    });
  }

  void onPressed() {
    setState(() {
      isSwitchOn = !isSwitchOn;
      dbR
          .child('Sensor Alert')
          .set({'Fire': isSwitchOn ? 1 : 0}); // Store 1 for true, 0 for false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fire Alert',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              onPressed: onPressed,
              child: Icon(Icons.power),
            ),
          ],
        ),
      ),
    );
  }
}
