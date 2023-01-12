import 'dart:io';

import 'package:camera/camera.dart';
import 'package:donation_tracker/pages/contact/contact_adde_controller.dart';

import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/sceene_reader.dart/camera.dart';
import 'package:donation_tracker/pages/sceene_reader.dart/sceen_reader.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:donation_tracker/widget/custom_dropdown.dart';
import 'package:donation_tracker/widget/custom_file_picker.dart';
import 'package:donation_tracker/widget/custom_radio_group.dart';
import 'package:donation_tracker/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class ContactForm extends StatefulWidget {
  final String? name;
  final String? nid;
  final XFile? imageFile;

  ContactForm({super.key, this.imageFile, this.name, this.nid});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(ContactController());
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  String? nid = "";

  String? name = "";
  var result;
  var nidImg;

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
  void initState() {
    name = widget.name;
    nid = widget.nid;
    imageFile = widget.imageFile;

    super.initState();
  }

  // dialog(contex, imageFile, result) {
  //   return showDialog(
  //       context: contex,
  //       builder: (
  //         BuildContext context,
  //       ) {
  //         return Dialog(
  //             insetPadding: EdgeInsets.symmetric(horizontal: 19, vertical: 40),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0)),
  //             // color: Colors.grey.withOpacity(.5),
  //             // margin: const EdgeInsets.all(20),
  //             child:
  //                 StatefulBuilder(// You need this, notice the parameters below:
  //                     builder: (BuildContext context, StateSetter setState) {
  //               _setState = setState;
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   if (textScanning) const CircularProgressIndicator(),
  //                   if (!textScanning && imageFile == null)
  //                     Container(
  //                       width: 300,
  //                       height: 300,
  //                       color: Colors.grey[300]!,
  //                     ),
  //                   if (imageFile != null) Image.file(File(imageFile!.path)),
  //                   SizedBox(
  //                     height: 16,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                           margin: const EdgeInsets.symmetric(horizontal: 5),
  //                           padding: const EdgeInsets.only(top: 10),
  //                           child: ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                               primary: Colors.white,
  //                               onPrimary: Colors.grey,
  //                               shadowColor: Colors.grey[400],
  //                               elevation: 10,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(16.0)),
  //                             ),
  //                             onPressed: () {
  //                               _setState(() {
  //                                 getImage(ImageSource.gallery);
  //                               });
  //                             },
  //                             child: Container(
  //                               margin: const EdgeInsets.symmetric(
  //                                   vertical: 5, horizontal: 5),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   Icon(
  //                                     Icons.image,
  //                                     size: 30,
  //                                   ),
  //                                   Text(
  //                                     "Gallery",
  //                                     style: TextStyle(
  //                                         fontSize: 13,
  //                                         color: Colors.grey[600]),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           )),
  //                       SizedBox(
  //                         width: 16,
  //                       ),
  //                       Container(
  //                           margin: const EdgeInsets.symmetric(horizontal: 5),
  //                           padding: const EdgeInsets.only(top: 10),
  //                           child: ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                               primary: Colors.white,
  //                               onPrimary: Colors.grey,
  //                               shadowColor: Colors.grey[400],
  //                               elevation: 10,
  //                               shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(8.0)),
  //                             ),
  //                             onPressed: () {
  //                               _setState(() {
  //                                 getImage(ImageSource.camera);
  //                               });
  //                             },
  //                             child: Container(
  //                               margin: const EdgeInsets.symmetric(
  //                                   vertical: 5, horizontal: 5),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: [
  //                                   Icon(
  //                                     Icons.camera_alt,
  //                                     size: 30,
  //                                   ),
  //                                   Text(
  //                                     "Camera",
  //                                     style: TextStyle(
  //                                         fontSize: 13,
  //                                         color: Colors.grey[600]),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           )),
  //                     ],
  //                   ),
  //                   Spacer(),
  //                   Center(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         OutlinedButton(
  //                             onPressed: (() {
  //                               setState(() {
  //                                 imageFile = null;
  //                               });
  //                               Navigator.pop(context);
  //                             }),
  //                             child: Text("Cencle")),
  //                         SizedBox(
  //                           width: 16,
  //                         ),
  //                         ElevatedButton(
  //                             onPressed: (() {
  //                               setState(() {
  //                                 print(name);
  //                                 name = result[1]["name"];
  //                                 print(name);
  //                                 nid = result[1]["nid"];
  //                                 nidImg = imageFile;
  //                               });
  //                               Navigator.pop(context);
  //                             }),
  //                             child: Text("Done")),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 16,
  //                   ),
  //                   Container(
  //                     child: Text(
  //                       scannedText,
  //                       style: TextStyle(fontSize: 20),
  //                     ),
  //                   )
  //                 ],
  //               );
  //             }));
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                await availableCameras()
                    .then((value) => Get.to(() => SceenerPage(cameras: value)));
                // result =
                //     await getImage(ImageSource.camera).then((data) {
                //   imageFile != null
                //       ? dialog(context, imageFile, result)
                //       : null;
                //   print(result);
                // });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Lottie.asset('assets/sc3.json',
                      height: 34, width: 34, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
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
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 280,
                          child: Text(
                              "fill-up  form correctly or Scanned Cleare NID to detecte Name and NID no."),
                        ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     await availableCameras().then((value) =>
                        //         Get.to(() => SceenerPage(cameras: value)));
                        //     // result =
                        //     //     await getImage(ImageSource.camera).then((data) {
                        //     //   imageFile != null
                        //     //       ? dialog(context, imageFile, result)
                        //     //       : null;
                        //     //   print(result);
                        //     // });
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: Colors.grey.shade100,
                        //         borderRadius: BorderRadius.circular(4),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black.withOpacity(0.2),
                        //             spreadRadius: 1,
                        //             blurRadius: 1,
                        //             offset: Offset(
                        //                 0, 1), // changes position of shadow
                        //           ),
                        //         ]),
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 8, vertical: 4),
                        //       child: Lottie.asset('assets/sc3.json',
                        //           height: 34, width: 34, fit: BoxFit.cover),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    initialValue: widget.name,
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
                      initialValue: ""),
                  SizedBox(
                    height: 8,
                  ),
                  CustomFilePicker2(
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
                    maxLength: 11,
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
                    initialValue: widget.nid,
                    keyboardType: TextInputType.number,
                    helperTxt: "Write receiver NID no. or BD certificate no.",
                    hint: "Write receiver NID no. or BD certificate no.",
                    onChange: (value) {
                      controller.map["nid_birth"] = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFilePicker2(
                      initialize: widget.imageFile,
                      require: false,
                      hint: "Selecte NID Photo",
                      onChange: (file) {
                        // file = File(widget.imageFile.path);
                        controller.image = file.path;
                        print("onchanggggg ${file}");
                      }),

                  SizedBox(
                    height: 20,
                  ),
                  // CustomTextField(
                  //   require: false,
                  //   helperTxt: "Write receiver BD certificate no.(if NID N/A)",
                  //   hint: "Write receiver BD certificate no.",
                  //   onChange: (value) {
                  //     controller.map["nid_birth"] = value.toString();
                  //   },
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
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
                        // var file = File(widget.imageFile!.path);
                        // controller.image = file;

                        print("onchanggggg ${controller.image}");
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

  // getImage(ImageSource source) async {
  //   try {
  //     final pickedImage = await ImagePicker().pickImage(source: source);
  //     if (pickedImage != null) {
  //       textScanning = true;

  //       setState(() {
  //         imageFile = pickedImage;
  //       });
  //       var result = getRecognisedText(pickedImage);
  //       return [pickedImage.path, result];
  //     }
  //   } catch (e) {
  //     textScanning = false;
  //     imageFile = null;
  //     scannedText = "Error occured while scanning";
  //     setState(() {});
  //     return "Choose image";
  //   }
  // }

  // getRecognisedText(XFile image) async {
    // final inputImage = InputImage.fromFilePath(image.path);
    // final textDetector = GoogleMlKit.vision.textRecognizer();
    // var recognisedText = await textDetector.processImage(inputImage);
    // await textDetector.close();
    // scannedText = "";
    // for (TextBlock block in recognisedText.blocks) {
    //   for (TextLine line in block.lines) {
    //     scannedText = scannedText + line.text + "\n";
    //   }
    // }
    // var totalL = scannedText.split(" ");
    // print(totalL);

    // if (totalL.contains("ID")) {
    //   var nidL = scannedText.split("ID NO:");
    //   var namL = scannedText.split("Name:");
    //   // var date = l.sublist(1).join('\n').trim();
    //   var nidl = nidL[1].split("\n");
    //   var namel = namL[1].split("\n");
    //   nid = nid[0].trim().toString();
    //   name = name[0].trim();
    // } else {
    //   return "Please choose clear nid photo";
    // }

    // // prefix[0];
    // print("list ${nid[0]}");
    // print("prefix ${name[0]}");
    // textScanning = false;
    // setState(() {});
    // return {"name": name, "nid": nid};
  // }

