import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intellinest/widgets/alert_tiles.dart';
import 'package:intellinest/widgets/all_good_box.dart';

class AlertBox extends StatefulWidget {
  const AlertBox({super.key});

  @override
  State<AlertBox> createState() => AlertBoxState();
}

class AlertBoxState extends State<AlertBox> {
  final dbR = FirebaseDatabase.instance.ref();
  var alert = Text('No Nothing');
  // final value = false;
  // late Icon alertIcon;
  Icon alertIcon = Icon(Icons.check);
  int sum = 0;
  int gas = 0;
  int fire = 0;

  StreamController<bool> _streamController = StreamController<bool>.broadcast();

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

    _streamController.add(true);
  }

  Widget alertTileSystem(
      {required String alertName, required Icon dialogAlertIcon}) {
    return AlertTile(
      alertName: alertName,
      dialogAlertIcon: dialogAlertIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alerts !'),
              content: StreamBuilder<bool>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return Container(
                    height: 200,
                    child: Column(
                      children: [
                        if (fire == 1)
                          alertTileSystem(
                            alertName: 'Fire Detected!',
                            dialogAlertIcon: Icon(Icons.fireplace_outlined),
                          ),
                        if (gas == 1)
                          alertTileSystem(
                            alertName: 'gas!',
                            dialogAlertIcon: Icon(Icons.gas_meter),
                          ),
                        if ((fire == 0) & (gas == 0)) AllGood(),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [alertIcon, alert],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
