// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:temp_email/utils/color.dart';
import 'package:temp_email/controller/domain_controller.dart';
import 'package:temp_email/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:temp_email/widget/header.dart';


class DomainScreen extends StatefulWidget {
  const DomainScreen({super.key});

  @override
  State<DomainScreen> createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {
  final DomainController domainController = Get.put(DomainController());
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Temp Mail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(height: 1,color: Colors.grey,),
          HeaderSection(heading:"Available Domain"),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: BigText(
                        text: "Tap to create account ot login",
                        size: 16,
                        color: Colors.blue,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
          Expanded(
            child: Obx(() {
              if (domainController.domains.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: domainController.domains.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.domain,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          BigText(
                            text: domainController.domains[index].domain,
                            size: 17,
                            color: Colors.white,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              domainController.saveDomainName(
                                  domainController.domains[index].domain);
                              Get.toNamed("/login-page", arguments: {
                                "domain":
                                    domainController.domains[index].domain,
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
         
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
