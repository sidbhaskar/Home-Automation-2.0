import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellinest/widgets/alert_box.dart';
import 'package:intellinest/widgets/bottom_sheet_fan.dart';
import 'package:intellinest/widgets/bottom_sheet_led.dart';
import 'package:intellinest/widgets/switch_fan_box.dart';
import 'package:intellinest/widgets/switch_led_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 25,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Hello,',
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
              'Siddharth',
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20, top: 20),
            child: Text(
              'W E L C O M E   T O   H O M E ',
              style: TextStyle(color: Colors.white38),
            ),
          ),

          //! content starts
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white30),
              ),
              child: AlertBox(),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return LedBottomScreen();
                    },
                  );
                },
                child: SwitchLedBox(),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return FanBottomScreen();
                    },
                  );
                },
                child: SwitchFanBox(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
