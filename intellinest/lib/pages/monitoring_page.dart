import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellinest/chart.dart';
import 'package:intellinest/widgets/alert_tiles.dart';
import 'package:intellinest/widgets/sensors_list.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Home',
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Alert System',
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                ),
              ),
            ),

            // SizedBox(
            //   height: 60,
            // ),

            //! content starts
            // Graph(),
            Text('Control your Sensors'),
            Column(
              children: [
                SensorsTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
