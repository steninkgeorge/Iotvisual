import 'package:flutter/material.dart';
import 'package:bounce/bounce.dart';
import 'package:get/get.dart';
import 'package:iotdashnew/screen/apikey.dart';
import 'package:iotdashnew/screen/controlSystem.dart';
import 'package:iotdashnew/screen/graph.dart';
import 'package:iotdashnew/screen/widgets/selection_bar_widget.dart';
import 'dart:js' as js;

class Home extends StatelessWidget {
  Home({super.key});

  void generateApiKey() {
    Get.to(ApiKeyGeneration(), transition: Transition.cupertino);
  }

  void navigateToVisualization() {
    // Add logic for navigating to the visualization screen
    Get.to(Graph(), transition: Transition.cupertino);
  }

  void navigateToControlSystem() {
    Get.to(ControlSystem(), transition: Transition.cupertino);
  }

  void navigateToSettings() {
    // Add logic for navigating to the settings screen
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selectionbar(
            oncallback: () {
              generateApiKey();
            },
            text: 'Generate API Key',
          ),
          selectionbar(
            oncallback: () {
              navigateToVisualization();
            },
            text: 'Visualization',
          ),
          selectionbar(
            oncallback: () {
              navigateToControlSystem();
            },
            text: 'Control System',
          ),
          selectionbar(
            oncallback: () {
              generateApiKey();
            },
            text: 'Settings',
          )
        ],
      ),
    );
  }
}
