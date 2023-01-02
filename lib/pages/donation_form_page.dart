import 'package:donation_tracker/pages/donation_controller.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_date_picker.dart';
import 'package:donation_tracker/widget/custom_dropdown.dart';
import 'package:donation_tracker/widget/custom_file_picker.dart';
import 'package:donation_tracker/widget/custom_radio_group.dart';
import 'package:donation_tracker/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DonationFormPage extends StatefulWidget {
  final String? name;
  DonationFormPage({super.key, required this.name});

  @override
  State<DonationFormPage> createState() => _DonationFormPageState();
}

class _DonationFormPageState extends State<DonationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(DonationController());

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
        title: Text(
          "Charity  Form",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Name: ${widget.name}",
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    require: true,
                    hint: "Write item name",
                    helperTxt: "Write item name",
                    onChange: (t) {
                      controller.map["item_name"] = t.toString();
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    require: false,
                    keyboardType: TextInputType.number,
                    helperTxt: "Total amount ৳",
                    hint: 'Total amount ৳',
                    onChange: (t) {
                      controller.map["total_amount"] = t.toString();
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    require: false,
                    keyboardType: TextInputType.number,
                    label: "Donation quantity",
                    helperTxt: "Write donation quantity ",
                    hint: "Write donation quantity ",
                    onChange: (t) {
                      controller.map["quantity"] = t.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: "Donation item details",
                    maxLines: 5,
                    helperTxt: "Write donation item details",
                    hint: "Write donation item details",
                    onChange: (t) {
                      controller.map["description"] = t.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDatePicker(
                    label: "Selecte date",
                    onChange: (String? v) {
                      controller.map["donation_date"] = v.toString();
                    },
                    hint: 'Selecte date',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFilePicker(
                      hint: "Donation Item Photo",
                      onChange: (file) {
                        // controller.image = file.path;
                        controller.images.add(file.path);
                        // controller.map["mimage"];
                        print(file.path);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomButton(
                      txtClr: Colors.white,
                      loading: controller.isLoading.value,
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          controller.postDonation();
                        } else {}
                        print(controller.images);
                      },
                      title: ' Add Donation',
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
