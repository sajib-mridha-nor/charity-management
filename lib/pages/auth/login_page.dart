import 'package:donation_tracker/pages/auth/auth_controller.dart';
import 'package:donation_tracker/pages/auth/registration_page.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            // child: Image.asset(
            //   "assets/polak2.jpg",
            //   height: double.infinity,
            //   fit: BoxFit.fill,
            // ),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blueAccent.withOpacity(.8)],
            ))),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  height: 160,
                  width: 270,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.blue.shade200,
                      ]),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 3,
                            color: Colors.black12)
                      ],
                      borderRadius: BorderRadius.circular(200).copyWith(
                          bottomRight: const Radius.circular(0),
                          topLeft: const Radius.circular(0))),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade900,
                          Colors.blue.shade200,
                        ]),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 3,
                              color: Colors.black12)
                        ],
                        borderRadius: BorderRadius.circular(200).copyWith(
                            bottomRight: const Radius.circular(0),
                            topLeft: const Radius.circular(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Donation',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                        ),
                        Text(
                          ' Tracker',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                              shadows: [
                                Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                              helperTxt: "Enter email",
                              hint: "Enter email",
                              onChange: (t) {
                                controller.map["email"] = t.toString();
                              }),
                          const SizedBox(
                            height: 26,
                          ),
                          CustomTextField(
                              helperTxt: "Enter password",
                              hint: "Enter password",
                              isPasswordField: true,
                              onChange: (t) {
                                controller.map["password"] = t.toString();
                              }),
                          const SizedBox(
                            height: 26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Obx(
                  () => CustomButton(
                      islog: true,
                      padding: EdgeInsets.all(8),
                      loading: controller.isLoading.value,
                      fontSize: 26,
                      txtClr: Colors.lightBlueAccent,
                      radius: 40,
                      color: Colors.white12,
                      onClick: (() {
                        print(controller.map);

                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        } else {}
                        print(controller.map);
                      }),
                      title: "Login"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  selectionColor: Colors.blue,
                  text: TextSpan(
                    text: "If don't account?",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(RegiPage());
                              // print(isNewSchool);
                              // setState(() {
                              //   isNewSchool =
                              //       !isNewSchool;
                              // });
                            },
                          text: ' Registration',
                          style: const TextStyle(shadows: [
                            Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 4.0,
                                color: Colors.black),
                          ], color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Align(alignment: Alignment.bottomCenter, child: Text("version:1.0.1"))
      ],
    ));
  }
}
