// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:temp_email/responsive/dimension.dart';
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
          HeaderSection(heading:"Available Diomain"),
           SizedBox(
            height:  AppDimensions.w5 ,
          ),
          Padding(
              padding:  EdgeInsets.all(AppDimensions.h10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin:  EdgeInsets.only(left: AppDimensions.w10),
                      child: BigText(
                        text: "Domains List",
                        size: AppDimensions.font20,
                        color: Colors.blue,
                      )),
                   SizedBox(
                    height: AppDimensions.h10,
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
                      margin: EdgeInsets.symmetric(horizontal: AppDimensions.w15,),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(AppDimensions.h10,)),
                      padding: EdgeInsets.all(AppDimensions.h20,),
                      child: Row(
                        children: [
                          Icon(
                            Icons.domain,
                            color: Colors.white,
                            size: AppDimensions.w20 ,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          BigText(
                            text: domainController.domains[index].domain,
                            size: AppDimensions.font20,
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
                              size:  AppDimensions.w20 ,
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
