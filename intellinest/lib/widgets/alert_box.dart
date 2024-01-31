import 'dart:async';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellinest/widgets/alert_tiles.dart';
import 'package:intellinest/widgets/all_good_box.dart';

class AlertBox extends StatefulWidget {
  const AlertBox({super.key});

  @override
  State<AlertBox> createState() => AlertBoxState();
}

class AlertBoxState extends State<AlertBox> {
  final dbR = FirebaseDatabase.instance.ref();
  var alert = const Text('Everything\nis fine');
  // final value = false;
  // late Icon alertIcon;
  Image alertIcon = Image.asset(
    'icons/checked.png',
    height: 80,
  );
  int sum = 0;
  int gas = 0;
  int fire = 0;

  StreamController<bool> _streamController = StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    dbR.child('Sensors/Fire').onValue.listen((event) {
      fire = event.snapshot.value as int;
      updateAlertState();
    });

    dbR.child('Sensors/Gas Sensor').onValue.listen((event) {
      gas = event.snapshot.value as int;
      updateAlertState();
    });
  }

  void updateAlertState() {
    sum = gas + fire;

    if (sum == 1) {
      if (fire == 1) {
        setState(() {
          alertIcon = Image.asset(
            'icons/flame.png',
            height: 80,
          );
          alert = Text(
            'Fire Alert!',
            style: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.amber[100],
              fontWeight: FontWeight.bold,
            ),
          );
        });
      } else if (gas == 1) {
        setState(() {
          alertIcon = Image.asset(
            'icons/gas-leak.png',
            height: 80,
          );
          alert = Text(
            'Gas leak!',
            style: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.blueGrey[500],
              fontWeight: FontWeight.bold,
            ),
          );
        });
      }
    } else if (sum == 0) {
      setState(() {
        alertIcon = Image.asset(
          'icons/checked.png',
          height: 80,
        );
        alert = Text(
          'Everything\nis fine',
          style: GoogleFonts.poppins(
            fontSize: 25,
            color: Colors.green[500],
            fontWeight: FontWeight.bold,
          ),
        );
      });
    } else if (sum > 1) {
      setState(() {
        alertIcon = Image.asset(
          'icons/alert.png',
          height: 80,
        );
        alert = Text(
          'Multiple Alerts\nFound !',
          style: GoogleFonts.poppins(
            fontSize: 25,
            color: Colors.red[700],
            fontWeight: FontWeight.bold,
          ),
        );
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
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 2.0, sigmaY: 2.0), // Adjust blur intensity as needed
              child: AlertDialog(
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
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: sum >= 1 ? Colors.red[200] : Colors.green[100],
        ),
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
