// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_email/controller/domain_controller.dart';
import 'package:temp_email/utils/api.dart';
import 'package:temp_email/widget/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final domainController = DomainController();

  loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
   final info = prefs.get(USER_INFO_SHARED_PREF_KEY);
   
    if (info!= null) {
      Timer(const Duration(seconds: 3), () => Get.offAllNamed("/email-list"));
     } else {
    Timer(const Duration(seconds: 3), () => Get.toNamed("/domain-page"));
     }
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
    domainController.fetchDomainList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text("Welcome to Temporary Email..",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                        ))),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset("assets/images/loading_email.gif"),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Protect Your Privacy .",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 112, 108, 108),
                      ),
                    ),
                    Text(" Avoid Spam",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    "It's time to Check your inbox. Someone may be looking for you ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed("/domain-page");
                    },
                    child: const RoundButton(text: "Get Started")),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
