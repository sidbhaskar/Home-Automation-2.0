import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WaterLevelProgress extends StatefulWidget {
  const WaterLevelProgress({Key? key}) : super(key: key);

  @override
  State<WaterLevelProgress> createState() => WaterLevelProgressState();
}

class WaterLevelProgressState extends State<WaterLevelProgress> {
  final DatabaseReference dbR = FirebaseDatabase.instance.reference();
  int waterLevel = 10;

  double mapValue(double inputValue, double inputMin, double inputMax,
      double outputMin, double outputMax) {
    return outputMin +
        (outputMax - outputMin) *
            (inputValue - inputMin) /
            (inputMax - inputMin);
  }

  @override
  void initState() {
    super.initState();

    // Set up a listener for real-time updates
    dbR.child('Sensors/Water Sensor').onValue.listen((event) {
      // Update the water level and trigger a rebuild
      setState(() {
        waterLevel = event.snapshot.value as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double mappedWaterLevel = mapValue(waterLevel.toDouble(), 0, 80, 0, 100);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Stack(
          children: [
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0.0, end: mappedWaterLevel / 100),
              builder: (context, double value, child) {
                return Container(
                  height: MediaQuery.sizeOf(context).height * 0.09,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  // width: 350,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(15),
                    value: value,
                    minHeight: 80,
                    backgroundColor: Colors.grey,
                    valueColor: mappedWaterLevel < 20
                        ? AlwaysStoppedAnimation<Color>(Colors.yellow.shade800)
                        : ((mappedWaterLevel > 20) & (mappedWaterLevel < 85))
                            ? AlwaysStoppedAnimation<Color>(
                                Colors.green.shade300)
                            : (mappedWaterLevel > 85)
                                ? AlwaysStoppedAnimation<Color>(
                                    Colors.red.shade300)
                                : AlwaysStoppedAnimation<Color>(
                                    Colors.green.shade300),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Water Level: ${mappedWaterLevel.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
