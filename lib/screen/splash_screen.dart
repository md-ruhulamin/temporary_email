
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temp_email/controller/domain_controller.dart';
import 'package:temp_email/responsive/dimension.dart';
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
            padding:  EdgeInsets.all(AppDimensions.w10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding:  EdgeInsets.only(top: AppDimensions.h10),
                    child:  Text("Welcome to Temporary Email..",
                        style: TextStyle(
                          fontSize: AppDimensions.font25,
                          color: Colors.green,
                        ))),
                 SizedBox(
                  height:  AppDimensions.h20,
                ),
                SizedBox(
                  width:  AppDimensions.w100 *3,
                  height: AppDimensions.h100*3,
                  child: Image.asset("assets/images/loading_email.gif"),
                ),
                 SizedBox(
                  height:  AppDimensions.h25,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Protect Your Privacy .",
                      style: TextStyle(
                        fontSize:  AppDimensions.font17,
                        color: Color.fromARGB(255, 112, 108, 108),
                      ),
                    ),
                    Text(" Avoid Spam",
                        style: TextStyle(
                          fontSize: AppDimensions.font17,
                          color: Colors.red,
                        )),
                  ],
                ),
              SizedBox(
                  height: AppDimensions.h15,
                ),
                 Text(
                    "It's time to Check your inbox. Someone may be looking for you ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDimensions.font15,
                      color: Colors.grey,
                    )),
                SizedBox(
                  height: AppDimensions.h15,
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
