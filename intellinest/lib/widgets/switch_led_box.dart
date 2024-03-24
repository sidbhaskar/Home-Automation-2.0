import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SwitchLedBox extends StatefulWidget {
  const SwitchLedBox({super.key});

  @override
  State<SwitchLedBox> createState() => _SwitchLedBoxState();
}

class _SwitchLedBoxState extends State<SwitchLedBox> {
  final dbR = FirebaseDatabase.instance.ref();

  bool isSwitchOn = false;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the 'Pins/LED' value
    dbR.child('Pin16/LED').onValue.listen((event) {
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
          .child('Pin16')
          .set({'LED': isSwitchOn ? 1 : 0}); // Store 1 for true, 0 for false
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.19,
      width: MediaQuery.sizeOf(context).width * 0.4,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isSwitchOn
                        ? Image.asset(
                            'icons/ceiling-lamp.png',
                            height: 38,
                          )
                        : Image.asset(
                            'icons/ceiling-lamp.png',
                            height: 38,
                            color: Colors.grey,
                          )),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5),
                  child: Text(
                    'Bulb',
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
                  activeTrackColor: Colors.blue,
                  value: isSwitchOn,
                  onChanged: (value) {
                    toggleBulb();
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
