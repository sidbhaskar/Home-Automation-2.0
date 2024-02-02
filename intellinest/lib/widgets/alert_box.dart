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
  int soil = 0;
  int water = 0;
  int waterdb = 0;

  double mapValue(double inputValue, double inputMin, double inputMax,
      double outputMin, double outputMax) {
    return outputMin +
        (outputMax - outputMin) *
            (inputValue - inputMin) /
            (inputMax - inputMin);
  }

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

    dbR.child('Sensors/Soil Moisture').onValue.listen((event) {
      soil = event.snapshot.value as int;
      updateAlertState();
    });

    dbR.child('Sensors/Water Sensor').onValue.listen((event) {
      // Update the water level and trigger a rebuild
      setState(() {
        waterdb = event.snapshot.value as int;
        // print(waterdb);
      });

      double mappedWaterLevel = mapValue(waterdb.toDouble(), 0, 70, 0, 100);
      print('mappe:$mappedWaterLevel');
      if (mappedWaterLevel < 95) {
        water = 0;
        updateAlertState();
      } else if (mappedWaterLevel >= 95) {
        water = 1;
        updateAlertState();
      }
    });
  }

  void updateAlertState() {
    sum = gas + fire + soil + water;

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
      } else if (soil == 1) {
        setState(() {
          alertIcon = Image.asset(
            'icons/plant.png',
            height: 80,
          );
          alert = Text(
            'Soil is dry!',
            style: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          );
        });
      } else if (water == 1) {
        setState(() {
          alertIcon = Image.asset(
            'icons/sea-level.png',
            height: 80,
          );
          alert = Text(
            'Water Overflow!',
            style: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.blue[500],
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
                backgroundColor: Colors.black87,
                title: Text(
                  'Alerts !',
                  style: GoogleFonts.poppins(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                content: StreamBuilder<bool>(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    return Container(
                      //!
                      height: sum > 2 ? 400 : 200,

                      child: Column(
                        children: [
                          if (fire == 1)
                            alertTileSystem(
                              alertName: 'Fire Detected!',
                              dialogAlertIcon: Icon(Icons.fireplace_outlined),
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          if (gas == 1)
                            alertTileSystem(
                              alertName: 'Gas leak!',
                              dialogAlertIcon: Icon(Icons.gas_meter),
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          if (soil == 1)
                            alertTileSystem(
                              alertName: 'Soil is dry!',
                              dialogAlertIcon: Icon(Icons.gas_meter),
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          if (water == 1)
                            alertTileSystem(
                              alertName: 'Water Overflow!',
                              dialogAlertIcon: Icon(Icons.gas_meter),
                            ),
                          if ((fire == 0) &
                              (gas == 0) &
                              (soil == 0) &
                              (water == 0))
                            AllGood(),
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
