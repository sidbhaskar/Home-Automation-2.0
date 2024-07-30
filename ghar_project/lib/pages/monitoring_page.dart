// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../widgets/sensors_list.dart';
// import '../widgets/sensors_list2.dart';
// import '../widgets/sensors_list3.dart';
// import '../widgets/sensors_list4.dart';
// import '../widgets/sensors_tile5.dart';

// class MonitoringPage extends StatefulWidget {
//   const MonitoringPage({super.key});

//   @override
//   State<MonitoringPage> createState() => _MonitoringPageState();
// }

// class _MonitoringPageState extends State<MonitoringPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(toolbarHeight: 30),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Text(
//                   'Home',
//                   style: GoogleFonts.poppins(
//                     fontSize: 35,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Text(
//                   'Alert System',
//                   style: GoogleFonts.poppins(
//                     fontSize: 35,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ),

//               // SizedBox(
//               //   height: 60,
//               // ),

//               //! content starts
//               // Graph(),
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Text(
//                   'Control your Sensors',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
//                 ),
//               ),
//               Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: SensorsTile(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: SensorsTile2(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: SensorsTile3(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: SensorsTile4(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: SensorsTile5(),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
