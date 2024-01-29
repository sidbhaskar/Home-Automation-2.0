import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  List<DataPoint> humidityDataPoints = [];
  List<DataPoint> temperatureDataPoints = [];
  Timer? timer;

  Future<Map<String, dynamic>> getDataFromFirebase(String dataType) async {
    String url =
        "https://review-2-3b64e-default-rtdb.firebaseio.com/.json"; // Replace with your Firebase URL
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('Time') &&
          jsonResponse.containsKey(dataType)) {
        final String time = jsonResponse['Time'].toString();
        final int data = jsonResponse[dataType] as int;
        return {
          'time': time,
          'data': data,
        };
      }
    }
    return {
      'time': '',
      'data': 0,
    };
  }

  Future<void> loadDataPoints() async {
    final Map<String, dynamic> humidityData =
        await getDataFromFirebase('Humidity');
    final Map<String, dynamic> temperatureData =
        await getDataFromFirebase('Temperature');

    setState(() {
      humidityDataPoints.add(DataPoint(
        humidityData['time'],
        humidityData['data'],
      ));
      temperatureDataPoints.add(DataPoint(
        temperatureData['time'],
        temperatureData['data'],
      ));

      if (humidityDataPoints.length > 10) {
        humidityDataPoints.removeAt(0);
        temperatureDataPoints.removeAt(0);
      }
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      loadDataPoints();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(
        text: 'Humidity and Temperature Graph',
        alignment: ChartAlignment.near,
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: Colors.white70,
          fontWeight: FontWeight.w700,
        ),
      ),
      enableAxisAnimation: true,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        minimum: 0,
        maximum: 110,
        interval: 20,
      ),
      series:
          //  <ChartSeries>
          [
        SplineAreaSeries<DataPoint, String>(
          splineType: SplineType.cardinal,
          cardinalSplineTension: 0.9,
          borderGradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 253, 153, 186)
            ],
          ),
          borderWidth: 3,
          animationDuration: 100,
          dataSource: humidityDataPoints,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(227, 134, 236, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ],
          ),
          xValueMapper: (DataPoint data, _) => data.time,
          yValueMapper: (DataPoint data, _) => data.data,
        ),
        SplineAreaSeries<DataPoint, String>(
          splineType: SplineType.cardinal,
          cardinalSplineTension: 0.9,
          borderGradient: const LinearGradient(
            colors: [Color.fromARGB(255, 255, 255, 255), Colors.orange],
          ),
          borderWidth: 3,
          animationDuration: 100,
          dataSource: temperatureDataPoints,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 134, 134, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ],
          ),
          xValueMapper: (DataPoint data, _) => data.time,
          yValueMapper: (DataPoint data, _) => data.data,
        ),
      ],
    );
  }
}

class DataPoint {
  DataPoint(this.time, this.data);
  final String time;
  final int data;
}
