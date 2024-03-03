// ignore_for_file: unused_import, duplicate_import, depend_on_referenced_packages, avoid_print
import 'package:get/get.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:temp_email/utils/api.dart';
import 'package:temp_email/controller/auth_controller.dart';
import 'package:temp_email/controller/domain_controller.dart';
import 'package:temp_email/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {

  final RxString _userEmail = "".obs;
  String get userEmial => _userEmail.value;

  Map<String, String> headers = {
    'Accept': 'application/ld+json',
    'Content-Type': 'application/json',
  };
  //email:"ruhul@yogirt.com"
  //password :ruhul

  Future<void> createAccount(
      {required String email,
      required String password,
      required String domain}) async {
    try {
      final response = await http.post(
        Uri.parse(CREATE_ACCOUNT_URL),
        headers: headers,
        body: jsonEncode({"address": "$email@$domain", "password": password}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        Get.snackbar(
            'Congratulations', "You have successfully created a account",
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed('login-page', arguments: {'domain': domain});
      } else {
        //  print(response.body);
        Map<String, dynamic> data = jsonDecode(response.body);
        String details = data["detail"];
        Get.snackbar('Failed to create a new account', "$details ",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  final Map<String, String> loginHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/ld+json',
  };
  Future<void> loginAccount(
      {required String email,
      required String password,
      required String domain}) async {
    try {
      final response = await http.post(
        Uri.parse(LOGIN_URL),
        headers: loginHeaders,
        body: jsonEncode({"address": email, "password": password}),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> data = jsonDecode(response.body);
        //     print("data $data");
        String token = data['token'];
        // print("Token $token");
        storeuserinfo(email, token, domain);
        Get.snackbar('Success', 'You are successfully logged in',
            snackPosition: SnackPosition.BOTTOM);

        Get.offAllNamed("/email-list");
      } else {
        print(response.body);
        Map<String, dynamic> responsedata = jsonDecode(response.body);
        Get.snackbar("Failed", responsedata['message'],
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> storeuserinfo(String email, String token, String domain) async {
    List<Map<String, String>> info = [
      {"email": email},
      {"token": token},
      {"domain": domain}
    ];
    String userinfo = json.encode(info);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_INFO_SHARED_PREF_KEY, userinfo);
    loaduserinfo();
  }

  Future<void> loaduserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(USER_INFO_SHARED_PREF_KEY);
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, String>> retrievedInfo =
          decodedList.map((e) => Map<String, String>.from(e)).toList();
      if (retrievedInfo[0]['email'] == null) {
        _userEmail.value = "";
      } else {
        _userEmail.value = retrievedInfo[0]['email']!;
      }
    } else {
      print('No info found in SharedPreferences');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_INFO_SHARED_PREF_KEY);
  }
}
