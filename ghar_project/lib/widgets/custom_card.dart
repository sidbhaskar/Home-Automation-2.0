import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double screenWidth;

  const CustomCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 75,
        width: screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            // SizedBox(width: 20),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            // Text(
            //   title,
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // if (value.isNotEmpty) SizedBox(height: 10),
            SizedBox(width: 10),
            if (value.isNotEmpty)
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  color: color,
                ),
              ),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
