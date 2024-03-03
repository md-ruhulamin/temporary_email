import 'package:get/get.dart';
import 'package:temp_email/screen/create_account_screen.dart';
import 'package:temp_email/screen/domain_list_screen.dart';
import 'package:temp_email/screen/login_screen.dart';
import 'package:temp_email/screen/message_list_screen.dart';
import 'package:temp_email/screen/splash_screen.dart';

class MyRoute {
  static const String initial = "/";
 static const String home = "/domain-page";
  static const String login = "/login-page";

  static const String createAccount = "/create-account";

  static const String emailList = "/email-list";
  static final routes = [
      GetPage(
      name: initial,
      transition: Transition.leftToRight,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: home,
      transition: Transition.leftToRight,
      page: () => const DomainScreen(),
    ),
    GetPage(
  name: login, // Route name
  transition: Transition.fadeIn, // Transition animation when navigating to this page
  page: () => LoginScreen(), // Widget associated with this route
),

    GetPage(
      name: createAccount,
      transition: Transition.fadeIn,
      page: () => const CreateAccountScreen(),
    ),
    GetPage(
      name: emailList,
      transition: Transition.fadeIn,
      page: () => const MessageListScreen(),
    ),
  ];
}
