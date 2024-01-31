import 'package:flutter/material.dart';

class AllGood extends StatelessWidget {
  const AllGood({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 175,
      width: 300,
      child: Center(
          child: Text(
        'Everthing is fine',
        style: TextStyle(fontSize: 22),
      )),
    );
  }
}
