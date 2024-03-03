import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:temp_email/controller/auth_controller.dart';
import 'package:temp_email/controller/domain_controller.dart';
import 'package:temp_email/controller/message_controller.dart';
import 'package:temp_email/controller/validation_controller.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => DomainController());
  Get.lazyPut(() => MessageController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ValidationController());
}
