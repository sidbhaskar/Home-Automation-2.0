import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SwitchFanBox extends StatefulWidget {
  const SwitchFanBox({super.key});

  @override
  State<SwitchFanBox> createState() => _SwitchFanBoxState();
}

class _SwitchFanBoxState extends State<SwitchFanBox> {
  final dbR = FirebaseDatabase.instance.ref();

  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the 'Pins/LED' value
    dbR.child('Pin17/FAN').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        // Update the switch state based on the received value
        setState(() {
          isSwitchOn = value == 1; // True if value is 1, false otherwise
        });
      }
    });
  }

  void toggleFan() {
    setState(() {
      isSwitchOn = !isSwitchOn;
      dbR
          .child('Pin17')
          .set({'FAN': isSwitchOn ? 1 : 0}); // Store 1 for true, 0 for false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 175,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30),
        borderRadius: BorderRadius.circular(25),
        color: Colors.white10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    //  isBulbOn ? Icons.lightbulb : Icons.lightbulb_outline
                    isSwitchOn ? Icons.wind_power : Icons.wind_power_outlined,
                    size: 42,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 5),
                  child: Text(
                    'Fan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' ${isSwitchOn ? 'ON' : 'OFF'}',
                  style: const TextStyle(color: Colors.white38),
                ),
                Switch(
                  activeColor: Colors.white,
                  value: isSwitchOn,
                  onChanged: (value) {
                    toggleFan();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
