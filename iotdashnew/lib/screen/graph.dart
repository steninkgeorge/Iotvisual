import 'dart:html';

import 'package:bounce/bounce.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iotdashnew/constant/sample.dart';
import 'package:iotdashnew/constant/sensor.dart';

// ... (your imports)
// ShapeDecoration
class Graph extends StatefulWidget {
  Graph({super.key});

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  List<RxList<SensorData>> graphDataList = List.generate(3, (_) => RxList([]));
  final RxInt count = RxInt(0);

  void createGraph(int graphIndex) {
    print(sensorDataList);
    if (sensorDataList.length > 0) {
      graphDataList[graphIndex].value = sensorDataList
          .map((data) => SensorData(
                time: data['time'],
                temperature: data['temperature'],
              ))
          .toList();
    }
  }

  void countIncrement() {
    print('clicked');
    count.value = count.value + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'dashboard',
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Bounce(
            onTap: () {
              for (int i = 0; i < graphDataList.length; i++) {
                createGraph(i);
              }

              countIncrement();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: MediaQuery.of(context).size.width / 4,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  'create graph',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Obx(
             () {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: count.value,
                  itemBuilder: (context, index) {
                    if (index < count.value) {
                      return Container(
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.all(8),
                        child: 
                           LineChart(
  LineChartData(
    gridData: FlGridData(show: false),
    titlesData: FlTitlesData(
      show: true,
      leftTitles:AxisTitles(axisNameWidget: Text('graph'))
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(
        color: const Color(0xff37434d),
        width: 1,
      ),
    ),
    minX: 0,
    maxX: sensorDataList.length.toDouble() - 1,
    minY: 20,
    maxY: 35,
    lineBarsData: [
      LineChartBarData(
        spots: List.generate(
          sensorDataList.length,
          (index) => FlSpot(
            index.toDouble(),
            sensorDataList[index]['temperature'],
          ),
        ),
        isCurved: true,
        color: Colors.blue,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ],
  ),
),

                      );
                    } else {
                      return Container(); // Return an empty container for extra grid items
                    }
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

