import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AlertBox extends StatefulWidget {
  const AlertBox({super.key});

  @override
  State<AlertBox> createState() => AlertBoxState();
}

class AlertBoxState extends State<AlertBox> {
  final dbR = FirebaseDatabase.instance.ref();
  var alert;
  // final value = false;
  late Icon alertIcon;
  // var alertIcon = Icon(Icons.check);
  int sum = 0;
  int gas = 0;
  int fire = 0;

  @override
  void initState() {
    super.initState();
    dbR.child('Alert/fire').onValue.listen((event) {
      fire = event.snapshot.value as int;
      updateAlertState();
    });

    dbR.child('Alert/gas').onValue.listen((event) {
      gas = event.snapshot.value as int;
      updateAlertState();
    });
  }

  void updateAlertState() {
    sum = gas + fire;

    if (sum == 1) {
      if (fire == 1) {
        setState(() {
          alertIcon = Icon(Icons.fireplace_outlined);
          alert = Text('Fire Alert!');
        });
      } else if (gas == 1) {
        setState(() {
          alertIcon = Icon(Icons.gas_meter);
          alert = Text('Gas leak!');
        });
      }
    } else if (sum == 0) {
      setState(() {
        alertIcon = Icon(Icons.check);
        alert = Text('No Nothing');
      });
    } else if (sum > 1) {
      setState(() {
        alertIcon = Icon(Icons.dangerous);
        alert = Text('Multiple Alerts found');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [alertIcon, alert],
        ),
      ),
    );
  }
}
