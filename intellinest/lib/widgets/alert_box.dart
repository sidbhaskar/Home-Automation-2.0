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
  final value = false;
  late Icon alertIcon;

  @override
  void initState() {
    super.initState();
    dbR.child('Alert').onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != false) {
        setState(() {
          alertIcon = Icon(Icons.dangerous_sharp);
          alert = Text('Alert!');
        });
      } else {
        setState(() {
          alertIcon = Icon(Icons.check);
          alert = Text('No nothing');
        });
      }
    });
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
