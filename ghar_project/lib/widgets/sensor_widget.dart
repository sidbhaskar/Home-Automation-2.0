import 'package:flutter/material.dart';
import 'custom_card.dart';

class TemperatureCard extends StatelessWidget {
  final int temperature;
  final double screenWidth;

  const TemperatureCard({
    Key? key,
    required this.temperature,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (temperature < 20) {
      color = Colors.white;
    } else if (temperature >= 20 && temperature <= 25) {
      color = Colors.blueAccent;
    } else if (temperature > 25 && temperature <= 32) {
      color = Colors.yellow;
    } else {
      color = Colors.redAccent;
    }

    return CustomCard(
      title: 'Temperature',
      value: '$temperature °C',
      icon: Icons.thermostat,
      color: color,
      screenWidth: screenWidth,
    );
  }
}

class HumidityCard extends StatelessWidget {
  final int humidity;
  final double screenWidth;

  const HumidityCard({
    Key? key,
    required this.humidity,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.blueAccent;
    return CustomCard(
      title: 'Humidity',
      value: '$humidity %',
      icon: Icons.water_drop,
      color: color,
      screenWidth: screenWidth,
    );
  }
}

class AlertsWidget extends StatelessWidget {
  final bool fireAlert;
  final bool gasAlert;
  final bool waterLevelAlert;
  final double screenWidth;

  const AlertsWidget({
    Key? key,
    required this.fireAlert,
    required this.gasAlert,
    required this.waterLevelAlert,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> alerts = [];
    if (fireAlert) alerts.add('Fire Alert');
    if (gasAlert) alerts.add('Gas Alert');
    if (waterLevelAlert) alerts.add('Water Level Alert');

    String alertText =
        alerts.isNotEmpty ? alerts.join(', ') : 'Everything is fine';
    Color alertColor = alerts.isNotEmpty ? Colors.redAccent : Colors.green;
    IconData alertIcon = alerts.isNotEmpty ? Icons.warning : Icons.check_circle;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: alertColor.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              alertIcon,
              size: 30,
              color: alertColor,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                alertText,
                style: TextStyle(
                  fontSize: 20,
                  color: alertColor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
