// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:get/get.dart';
import 'package:temp_email/model/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MessageController extends GetxController {
  String token = '';
  String jsonData = '';
  RxList<Message> messageList = <Message>[].obs;
  List<Message> parseMessages(String jsonStr) {
    final parsed =
        jsonDecode(jsonStr)['hydra:member'].cast<Map<String, dynamic>>();
    return parsed.map<Message>((json) => Message.fromJson(json)).toList();
  }
  
  Future<void> loadallMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('userinfo');
    if (jsonString != null) {
      List<dynamic> decodedList = json.decode(jsonString);
      List<Map<String, String>> retrievedInfo =
          decodedList.map((e) => Map<String, String>.from(e)).toList();
      if (retrievedInfo[1]['token'] == null) {
        token = "";
      } else {
        token = retrievedInfo[1]['token']!;
      }
      final response = await http
          .get(Uri.parse('https://api.mail.tm/messages?page=1'), headers: {
        'accept': 'application/ld+json',
        'Authorization': 'Bearer $token'
        //   'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3MDkyMDUzMTksInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJhZGRyZXNzIjoicnVodWxAeW9naXJ0LmNvbSIsImlkIjoiNjVlMDU4NjkxZDg1YmEyMDdjMDZlYmUyIiwibWVyY3VyZSI6eyJzdWJzY3JpYmUiOlsiL2FjY291bnRzLzY1ZTA1ODY5MWQ4NWJhMjA3YzA2ZWJlMiJdfX0.-ROjgqN15Cryx6Vmk_MwtRdm_sFfSW3CJXhHRcm3cFfm4ziwyaZcGaLHu9PIbPgDySugmXW0YroSMzDutvcMaw'
      });
      if (response.statusCode == 200) {
        jsonData = response.body;
      }
//     String jsonData1 = '''
// {
//     "@context": "/contexts/Message",
//     "@id": "/messages",
//     "@type": "hydra:Collection",
//     "hydra:totalItems": 2,
//     "hydra:member": [
//         {
//             "@id": "/messages/65e210bc23841538a72e275c",
//             "@type": "Message",
//             "id": "65e210bc23841538a72e275c",
//             "msgid": "<CAPYg5_aVHgm85CEnxCRE_7_+MNzizwhtnMz0Gb0rUZeWyzhrPw@mail.gmail.com>",
//             "from": {
//                 "address": "aminr9253@gmail.com",
//                 "name": "Ruhul Amin"
//             },
//             "to": [
//                 {
//                     "address": "ruhul@yogirt.com",
//                     "name": ""
//                 }
//             ],
//             "subject": "Second Text Email",
//             "intro": "Email Body .2nd Time",
//             "seen": false,
//             "isDeleted": false,
//             "hasAttachments": false,
//             "size": 2997,
//             "downloadUrl": "/messages/65e210bc23841538a72e275c/download",
//             "sourceUrl": "/sources/65e210bc23841538a72e275c",
//             "createdAt": "2024-03-01T17:30:17+00:00",
//             "updatedAt": "2024-03-01T17:30:36+00:00",
//             "accountId": "/accounts/65e058691d85ba207c06ebe2"
//         },
//         {
//             "@id": "/messages/65e068d14dd816e3a66bf100",
//             "@type": "Message",
//             "id": "65e068d14dd816e3a66bf100",
//             "msgid": "<CAAsYOYgoO3Cju_rT0mU8wOutnGQCoSpG+WGz7=A6srzKNU9KGg@mail.gmail.com>",
//             "from": {
//                 "address": "md.ruhulamin1863@gmail.com",
//                 "name": "Md. Ruhul Amin"
//             },
//             "to": [
//                 {
//                     "address": "ruhul@yogirt.com",
//                     "name": ""
//                 }
//             ],
//             "subject": "testing",
//             "intro": "This is a test email",
//             "seen": false,
//             "isDeleted": false,
//             "hasAttachments": false,
//             "size": 3016,
//             "downloadUrl": "/messages/65e068d14dd816e3a66bf100/download",
//             "sourceUrl": "/sources/65e068d14dd816e3a66bf100",
//             "createdAt": "2024-02-29T11:21:40+00:00",
//             "updatedAt": "2024-02-29T11:21:53+00:00",
//             "accountId": "/accounts/65e058691d85ba207c06ebe2"
//         }
//     ]
// }
// ''';
      // Parse JSON data into a list of Message objects
      List<Message> messages = parseMessages(jsonData);
      messageList.value = messages;
      // Accessing elements
      // for (var message in messages) {
      //   print("Message ID: ${message.id}");
      //   print("Subject: ${message.subject}");
      //   print("From: ${message.from.address}");
      //   print("To: ${message.to[0].address}");
      //   print("Intro: ${message.intro}");
      //   print("Size: ${message.size}");
      //   print("CreatedAt: ${message.createdAt}");
      //   print("UpdatedAt: ${message.updatedAt}");
      //   print('');
      // }
    }
  }
}
