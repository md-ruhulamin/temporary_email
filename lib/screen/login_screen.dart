import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:temp_email/responsive/dimension.dart';
import 'package:temp_email/utils/color.dart';
import 'package:temp_email/controller/auth_controller.dart';
import 'package:temp_email/controller/validation_controller.dart';
import 'package:temp_email/widget/custom_button.dart';
import 'package:temp_email/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:temp_email/widget/header.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValidationController validationController =
      Get.put(ValidationController());

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final arguments = Get.arguments as Map<String, String>;
  // Access using key and null-safety
  final authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String domain = arguments['domain']!;
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Temp Mail",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(color: Colors.grey,height: 1,),
            const HeaderSection(heading: "Login"),
             SizedBox(
              height:  AppDimensions.h20 ,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:  AppDimensions.w10 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Icon(
                    Icons.lock,color: Colors.blue,
                    size:  AppDimensions.w70 ,
                  ),
                   SizedBox(
                    height:  AppDimensions.h20
                  ),
                  BigText(
                    text: "Welcome back you,ve been missed",
                    size:  AppDimensions.font17 ,
                  ),
                   SizedBox(
                    height:  AppDimensions.h20 ,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.email),
                                      filled: true,
                                      prefixIconColor: Colors.green,
                                      fillColor: AppColors().primaryWhite,
                                      errorText: validationController
                                              .isUseremailError.value
                                          ? 'Please enter an email'
                                          : null,
                                      hintText: 'Enter Email',
                                      hintStyle: GoogleFonts.workSans(
                                        textStyle:  TextStyle(
                                            fontSize:  AppDimensions.font15 ,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Email can\'t be empty';
                                      }
                                      if (text.length < 4) {
                                        return 'Email is too short';
                                      }
                                      return null;
                                    },
                                    onChanged:
                                        validationController.validateUserEmail,
                                  ),
                                ),
                              ]),
                           SizedBox(
                            height:  AppDimensions.h10,
                          ),
                          Obx(
                            () => TextFormField(
                              obscureText:
                                  validationController.isPasswordObscure.value,
                              controller: passwordController,
                              decoration: InputDecoration(
                                // border: InputBorder.none,
                                focusColor: Colors.blue,
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: Obx(() => IconButton(
                                      onPressed: () {
                                        validationController
                                                .isPasswordObscure.value =
                                            !validationController
                                                .isPasswordObscure.value;
                                      },
                                      icon: validationController
                                              .isPasswordObscure.value
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    )),

                                filled: true,
                                prefixIconColor: Colors.green,
                                fillColor: AppColors().primaryWhite,
                                suffixIconColor: Colors.green,
                                errorText:
                                    validationController.isPasswordError.value
                                        ? 'Please enter a password'
                                        : null,
                                hintText: 'Enter Password',
                                hintStyle: GoogleFonts.workSans(
                                  textStyle:  TextStyle(
                                      fontSize:  AppDimensions.font15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password can\'t be empty';
                                }
                                if (text.length < 4) {
                                  return 'Password too short';
                                }
                                return null;
                              },
                              onChanged: validationController.validatePassword,
                            ),
                          ),
                           SizedBox(
                            height:  AppDimensions.h20*1.5,
                          ),
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authController.loginAccount(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              domain: domain);
                        }
                      },
                      child: const RoundButton(text: "Login")),
                   SizedBox(
                    height: AppDimensions.h10
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text.rich(TextSpan(children: [
                         TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppDimensions.font15,
                            )),
                        TextSpan(
                           
                          text: "Create now",
                          style:  TextStyle(
                            fontSize:  AppDimensions.font15,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed("/create-account", arguments: {
                                'domain': domain,
                              });
                            },
                        ),
                      ])),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
