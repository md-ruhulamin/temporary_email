// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:temp_email/responsive/dimension.dart';
import 'package:temp_email/utils/color.dart';
import 'package:temp_email/controller/auth_controller.dart';
import 'package:temp_email/controller/message_controller.dart';
import 'package:temp_email/model/message_model.dart';
import 'package:temp_email/widget/custom_text.dart';
import 'package:temp_email/widget/header_text.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  MessageController messageController = Get.put(MessageController());
  final authcontroller = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    authcontroller.loaduserinfo();
    messageController.loadallMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors().backgroundColor,
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  AuthController().logout();
                  Get.offAllNamed("domain-page");
                },
                child: Icon(Icons.logout)),
            SizedBox(
              width: AppDimensions.w10,
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            "Temp Mail",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [  Container(height: 1,color: Colors.grey,),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                  
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.all(AppDimensions.w5),
                        child: Obx(() =>
                            ScreenHeaderText(text: authcontroller.userEmial))),
                    Container(
                      width: double.infinity,
                      height: AppDimensions.h20,
                      decoration:  BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppDimensions.h20*2.5))),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:  AppDimensions.w15,vertical:  AppDimensions.h5),
                        
                        decoration: BoxDecoration(
                            color: AppColors().backgroundColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppDimensions.h20*2.5))),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => BigText(
                            text:
                                "Message  (${messageController.messageList.length.toString()})"),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          messageController.loadallMessage();
                        },
                      ),
                    ],
                  ),
                      ),
                    ),
                  ],
                )),
           
            Expanded(child: Obx(() {
              if (messageController.messageList.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: messageController.messageList.length,
                    itemBuilder: (context, index) {
                      Message message = messageController.messageList[index];
                      return MessageCard(
                          date: message.createdAt,
                          from: message.from.address,
                          to: message.to[0].address,
                          subject: message.subject,
                          details: message.intro);
                    });
              }
            }))
          ],
        ));
  }
}

class MessageCard extends StatelessWidget {
  final String date;
  final String from;
  final String to;
  final String subject;
  final String details;
  const MessageCard(
      {super.key,
      required this.date,
      required this.from,
      required this.to,
      required this.subject,
      required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.w10, vertical:  AppDimensions.h5),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          boxShadow: [
            BoxShadow(offset: Offset(-1, -1), blurRadius: 2, color: Colors.grey)
          ],
          borderRadius: BorderRadius.circular( AppDimensions.w10)),
      padding: EdgeInsets.all( AppDimensions.h10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MessageInfo(
          sub: "From",
          subtetxt: from,
        ),
        MessageInfo(
          sub: "To",
          subtetxt: to,
        ),
        MessageInfo(
          sub: "Time",
          subtetxt: date,
        ),
        MessageInfo(
          sub: "Subject",
          subtetxt: subject,
        ),
        MessageInfo(
          sub: "Details",
          subtetxt: details,
        )
      ]),
    );
  }
}

class MessageInfo extends StatelessWidget {
  final String sub;
  final String subtetxt;
  const MessageInfo({
    super.key,
    required this.sub,
    required this.subtetxt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sub,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,fontSize: AppDimensions.font15),
          ),
          Text(subtetxt),
        ],
      ),
    );
  }
}
