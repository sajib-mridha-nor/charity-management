import 'package:donation_tracker/pages/contact/contact_adde_controller.dart';

import 'package:donation_tracker/pages/donation_form_page.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_dropdown.dart';
import 'package:donation_tracker/widget/custom_file_picker.dart';
import 'package:donation_tracker/widget/custom_radio_group.dart';
import 'package:donation_tracker/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ContactForm extends StatelessWidget {
  ContactForm({super.key});
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ContactController());

  List<String> _union = [
    "Chamari",
    "Chhatardighi",
    "Chowgram",
    "Dahia",
    "Hatiandaha",
    "Italy",
    "Kalom",
    "Lalore",
    "Ramananda",
    "Khajura",
    "Sherkole",
    "Tajpur",
    "Sukash"
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(.5),
        centerTitle: true,
        title: Text("Add Contract"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hint: "Write receiver name",
                    helperTxt: "Write receiver name",
                    onChange: (t) {
                      controller.map["name"] = t.toString();
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomRadioGroup(
                      require: false,
                      onChange: ((index, value) {
                        controller.map["gender"] = value.toString();
                      }),
                      label: "Gender",
                      labelStyle:
                          textTheme.displayMedium?.copyWith(fontSize: 18),
                      items: ["Male", "Female"],
                      initialValue: "Male"),
                  SizedBox(
                    height: 8,
                  ),
                  CustomFilePicker(
                      require: false,
                      hint: "Selecte profile Photo",
                      onChange: (file) {
                        controller.profile = file.path;
                        print("onchanggggg ${file}");
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.phone,
                    helperTxt: "Write receiver phone no.",
                    hint: "Write receiver phone no.",
                    onChange: (value) {
                      controller.map["mobile"] = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    require: false,
                    keyboardType: TextInputType.number,
                    helperTxt: "Write receiver NID no.",
                    hint: "Write receiver NID no.",
                    onChange: (value) {
                      controller.map["nid_birth"] = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFilePicker(
                      require: false,
                      hint: "Selecte NID Photo",
                      onChange: (file) {
                        controller.image = file.path;
                        print("onchanggggg ${file}");
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    require: false,
                    helperTxt: "Write receiver BD certificate no.(if NID N/A)",
                    hint: "Write receiver BD certificate no.",
                    onChange: (value) {
                      controller.map["nid_birth"] = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    helperTxt: "Write receiver address",
                    hint: "Write receiver address",
                    onChange: (value) {
                      controller.map["address"] = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropdown(
                      // label: "Union",
                      items: _union,
                      hint: "Union",
                      onChange: (value) {
                        controller.map["union"] = value.toString();
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomButton(
                      loading: controller.isLoading.value,
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          controller.postContacts();
                        } else {
                          print("object");
                        }
                        print(controller.map);
                      },
                      title: 'Add Contact',
                      txtClr: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
