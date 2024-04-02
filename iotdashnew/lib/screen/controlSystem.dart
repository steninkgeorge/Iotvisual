import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iotdashnew/controller/auth_controller.dart';
import 'package:iotdashnew/screen/apikey.dart';

class ControlSystem extends StatelessWidget {
  final RxBool isSwitched = true.obs;

  AuthController _authController = Get.put(AuthController());
  Future<void> pushToggle(bool value) async {
    final String user_id = '${_authController.cookie}';
    print(user_id);
    int intValue = value ? 1 : 0; // Convert true to 1 and false to 0
    print(intValue);
    print(_authController.cookie);
    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse('http://192.168.1.2:2020/control/${user_id}/$intValue'),
        body: {'isSwitched': value.toString()},
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Handle success response if needed
        print('Toggle state pushed successfully');
      } else {
        // Handle errors or other status codes
        print('Failed to push toggle state: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control System'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => SwitchListTile(
                title: Text(
                  isSwitched.value ? 'System is ON' : 'System is OFF',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                value: isSwitched.value,
                onChanged: (value) {
                  isSwitched.value = value;
                  pushToggle(value);
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Notice:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'To control the system, you need to generate an API key and connect your device.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.to(ApiKeyGeneration());
              },
              child: Text('Generate API Key & Connect Device'),
            ),
          ],
        ),
      ),
    );
  }
}
