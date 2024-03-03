// ignore_for_file: dead_code, avoid_print, unused_local_variable, depend_on_referenced_packages

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:temp_email/utils/api.dart';
import 'package:temp_email/model/domain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DomainController extends GetxController {
  RxList<Domain> domains = <Domain>[].obs;
  Future<List<Domain>> fetchDomainList() async {
    final response = await https.get(Uri.parse(DOMAIN_LIST_URL));
    try {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonMemberList = jsonResponse['hydra:member'];
      domains.value =
          jsonMemberList.map((json) => Domain.fromJson(json)).toList();
  //    print(domains.length);
      return domains;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<void> saveDomainName(String domain) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('domain', domain);
   
  }
}
