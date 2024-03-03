import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:temp_email/utils/color.dart';
import 'package:temp_email/controller/auth_controller.dart';
import 'package:temp_email/controller/validation_controller.dart';
import 'package:temp_email/widget/custom_button.dart';
import 'package:temp_email/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:temp_email/widget/header.dart';

import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final ValidationController validationController =
      Get.put(ValidationController());
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var authcontroller = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, String>;
    final String domain =
        arguments['domain']!; // Access using key and null-safety

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
            Container(
              height: 1,
              color: Colors.grey,
            ),
            const HeaderSection(
              heading: "Create New Account",
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //     margin: const EdgeInsets.only(left: 5),
                  //     child: BigText(
                  //       text: "Tap to create account ot login",
                  //       size: 16,
                  //       color: Colors.blue,
                  //     )),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  const Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: "Let's create an accouont for you",
                    size: 17,
                  ),
                  const SizedBox(
                    height: 10,
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
                                          ? 'Please enter a username'
                                          : null,
                                      hintText: 'Enter Email  Address',
                                      hintStyle: GoogleFonts.workSans(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Email Can\'t be empty';
                                      }
                                      if (text.length < 4) {
                                        return 'Too short';
                                      }
                                      return null;
                                    },
                                    onChanged:
                                        validationController.validateUserEmail,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  child: Text(
                                    "@$domain",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 10,
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
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Field Can\'t be empty';
                                }
                                if (text.length < 4) {
                                  return 'Too short';
                                }
                                return null;
                              },
                              onChanged: validationController.validatePassword,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authcontroller.createAccount(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              domain: domain);
                        }
                      },
                      child: const RoundButton(text: "Create")),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed("/login-page",
                                    arguments: {"domain": domain});
                              },
                            text: "Login",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            ))
                      ])),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
