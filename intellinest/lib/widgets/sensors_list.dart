import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SensorsTile extends StatefulWidget {
  const SensorsTile({
    Key? key,
  }) : super(key: key);

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
    dbR.child('Sensors Alerts/Fire/Fire').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        // Update the switch state based on the received valuez
        setState(() {
          isSwitchOn = value == 1; // True if value is 1, false otherwise
        });
      }
    });
  }

  void toggleBulb() {
    setState(() {
      isSwitchOn = !isSwitchOn;
      dbR
          .child('Sensors Alert/Fire')
          .set({'Fire': isSwitchOn ? 1 : 0}); // Store 1 for true, 0 for false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!...
            const Text(
              'Fire Sensor',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              value: isSwitchOn,
              onChanged: (value) {
                toggleBulb();
              },
            ),
          ],
        ),
      ),
    );
  }
}
