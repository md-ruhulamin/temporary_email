// ignore_for_file: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:temp_email/controller/domain_controller.dart';
import 'package:temp_email/controller/message_controller.dart';
class MyBinding implements Bindings {
  @override
  void dependencies() {
    final DomainController domainController = Get.put(DomainController());
    domainController.fetchDomainList();
    final messageController = Get.put(MessageController());
    messageController.loadallMessage();
  }
}
