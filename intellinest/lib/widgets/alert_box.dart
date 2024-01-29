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

    //! fire alert
    dbR.child('Alert/fire').onValue.listen((event) {
      final fire = event.snapshot.value;
      if (fire == 0) {
        setState(() {
          alertIcon = Icon(Icons.check);
          alert = Text('No nothing f');
        });
      } else {
        setState(() {
          alertIcon = Icon(Icons.fireplace_outlined);
          alert = Text('Fire Alert!');
        });
      }
    });

    //! gas leak
    dbR.child('Alert/gas').onValue.listen((event) {
      final gas = event.snapshot.value;
      if (gas == 0) {
        setState(() {
          alertIcon = Icon(Icons.check);
          alert = Text('No nothing g');
        });
      } else {
        setState(() {
          alertIcon = Icon(Icons.gas_meter);
          alert = Text('Gas Leak!');
        });
      }
    });

    var info = dbR.child('Alert/gas').onValue.listen((event) {
      final 
    });
     

    //! all
    dbR.child('Alert/all').onValue.listen((event) {
      final all = event.snapshot.value;
      sum = gas + fire;
      print(sum);
      if (sum > 1) {
        setState(() {
          alertIcon = Icon(Icons.dangerous);
          alert = Text('Many alerts detected!');
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
