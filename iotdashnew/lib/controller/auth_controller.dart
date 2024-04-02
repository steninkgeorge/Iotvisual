import 'dart:convert';

import 'package:get/get.dart';
import 'package:iotdashnew/service/http_service.dart';

import 'dart:js' as js; // Import the js library

class AuthController extends GetxController {
  final RxString _cookie = RxString('');
  String get cookie => _cookie.value;

  void setCookie(String name, String value) {
    final expires = DateTime.now().add(const Duration(days: 7));

    js.context['document'].cookie = '$name=$value; expires=${expires.toUtc()}';
  }

  Future<void> login(String username, String password) async {
    Map<String, dynamic> data = {'username': username, 'password': password};

    try {
      var res = await HttpService.postRequest('/authenticate', data);
      Get.snackbar('success', 'login successfull');
      var decodedRes = json.decode(res);
      print(res);
      var _id = decodedRes['user_id'];
      setCookie('_id', _id);
      _cookie.value = _id;
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('error', e.toString());
      print('Error: $e');
    }
  }

  Future<void> signup(String username, String password) async {
    Map<String, dynamic> data = {'username': username, 'password': password};
    try {
      var res = await HttpService.postRequest('/register', data);
      print(res);
      Get.snackbar('success', 'now please login');

      print(res);
    } catch (e) {
      Get.snackbar('error', e.toString());
      print(e);
    }
  }
}
