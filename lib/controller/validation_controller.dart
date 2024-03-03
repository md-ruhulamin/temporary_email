
import 'package:get/get.dart';

class ValidationController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  RxBool isPasswordObscure = true.obs;
  var isUseremailError = false.obs;
  var isPasswordError = false.obs;

  void validateUserEmail(String value) {
    username.value = value;
    if (value.isEmpty) {
      isUseremailError.value = true;
    } else {
      isUseremailError.value = false;
    }
  }

  void validatePassword(String value) {
    password.value = value;
    if (value.isEmpty) {
      isPasswordError.value = true;
    } else {
      isPasswordError.value = false;
    }
  }
}
