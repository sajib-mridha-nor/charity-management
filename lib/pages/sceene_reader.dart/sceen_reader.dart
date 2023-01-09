import 'dart:io';

import 'package:camera/camera.dart';
import 'package:donation_tracker/pages/contact/contact_form.dart';
import 'package:donation_tracker/pages/sceene_reader.dart/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class SceenerPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const SceenerPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<SceenerPage> createState() => _SceenerPageState();
}

class _SceenerPageState extends State<SceenerPage> {
  bool textScanning = false;
  bool reTake = true;
  late CameraController controller;

  XFile? imageFile;

  String scannedText = "";
  String scannedText2 = "";
  var nid = "";
  var name = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition example"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                !textScanning && imageFile == null
                    ? Center(
                        child: SizedBox(
                          height: 350,
                          width: 400,
                          child: CameraPreview(
                            controller,
                            child: Image.asset("assets/s.png"),
                          ),
                        ),
                      )
                    : imageFile != null
                        ? Image.file(
                            File(
                              imageFile!.path,
                            ),
                            height: 350,
                            width: 400,
                            fit: BoxFit.fill,
                          )
                        : const CircularProgressIndicator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () async {
                            if (reTake) {
                              imageFile = await controller.takePicture();
                              getRecognisedText(imageFile!);
                              reTake = false;
                            } else {
                              imageFile = null;
                              reTake = true;
                            }

                            setState(() {});
                            // Get.to(() => CameraPage(cameras: ));
                            // await availableCameras().then((value) =>
                            //     Get.to(() => CameraPage(cameras: value)));
                            // print("object");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  reTake ? "Take" : "ReTake",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "Name: $name",
                    // nid == null ? "" : nid,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: Text(
                    "NID: $nid",
                    // name == null ? "" : name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          autofocus: false,
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.blue.shade200),
                            // backgroundColor: MaterialStateProperty.all(
                            //     Colors.blue.shade200),
                            elevation: MaterialStateProperty.all(4),
                            // shadowColor:
                            //     MaterialStateProperty.all(Colors.blue)
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Cencle",
                          )),
                      SizedBox(
                        width: 48,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade200),
                              elevation: MaterialStateProperty.all(4),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: (() {
                            var nidv = nid.trim();
                            var l = nidv.split(" ");
                            String fnid = "";
                            l.forEach((element) {
                              fnid = fnid + element;
                            });

                            // var nidint = int.parse(nidv);
                            Get.to(ContactForm(
                              imageFile: imageFile,
                              name: name,
                              nid: fnid,
                            ));
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Done"),
                          )),
                    ],
                  ),
                )
              ],
            )),
      )),
    );
  }

  getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        var result = getRecognisedText(pickedImage);
        return [pickedImage.path, result];
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
      return "Choose image";
    }
  }

  getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    var nidIndex = 7;
    var nidIndex2 = 7;
    var recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
        scannedText2 = scannedText + line.text;
      }
    }
    var totalL = await scannedText2.split(" ");
    var totalLc = scannedText.split("\n");
    print("scn $scannedText");
    print("q $totalL");
    print("tt $totalLc");

    if (totalL.contains("NO:") ||
        totalLc.contains("No.") ||
        totalL.contains("Birth")) {
      if (totalL.contains("NO:")) {
        setState(() {
          print("tem");
          print("sccc tt $scannedText");

          var nidL = scannedText.split("ID NO:");
          var namL = scannedText.split("Name:");
          // var date = l.sublist(1).join('\n').trim();
          var nidl = nidL[1].split("\n");
          var namel = namL[1].split("\n");
          print("sp list ${nidl}");
          print("sp lsi ${namel}");

          nid = nidl[0].trim().toString();
          name = namel[0].trim();
          print("list ${nid[0]}");
          print("prefix ${name[0]}");
        });
        return;
      } else {
        print("sccc ${scannedText2}");
        var all = scannedText2.split("\n");
        var all2 = scannedText2.split(" ");
        print("all${all}");
        print("all2 ${all2}");
        final nameIndex = all.indexWhere(
          (element) => (element == "Name"),
        );
        setState(() {
          name = all[nameIndex + 1];
        });
        print("namee  ${all[nameIndex + 1]}");

        if (all.contains("NID No.")) {
          setState(() {
            nidIndex = all.indexWhere(
              (element) => (element.toLowerCase() == "nid no."),
            );
            if (all.length - 1 > nidIndex) {
              nid = all[nidIndex + 1];
            }
            if (all.length - 1 == nidIndex) {
              nid = all[nidIndex - 1];
              print("5  $nid");
            }
            if (all.length - 1 <= nidIndex + 2) {
              nid = all[nidIndex + 2];

              print("6  ${all[nidIndex2 + 1]}");
            }
          });

          // if (all.length - 1 < nidIndex - 1) {
          //   setState(() {
          //     nid = all[nidIndex];
          //   });
          //   print("4  $nid");
          // }

          // if (all.length - 1 == nidIndex2 - 1) {
          //   setState(() {
          //     nid = all[nidIndex2 - 2];
          //   });
          //   print("4  ${all[nidIndex2 - 2]}");
          // }
          // if (all.length - 1 == nidIndex2) {
          //   setState(() {
          //     nid = all[nidIndex2 - 1];
          //   });
          //   print("3  ${all[nidIndex2 - 1]}");
          // }
          // if (all.length - 1 == nidIndex2 - 2) {
          //   setState(() {
          //     nid = all[nidIndex2 + 1];
          //   });
          //   print("3  ${all[nidIndex2 + 1]}");
          // }
          // setState(() {
          //   if (all.length - 1 >= nidIndex) {
          //     nid == all[(nidIndex + 1)];
          //     print("index-1 ${nid}");
          //   } else {
          //     nid == all[(nidIndex - 1)];
          //     print("index+1 ${nid}");
          //   }

          //   name = all[nameIndex + 1];
          //   print("list ${nid[0]}");
          //   print("prefix ${name[0]}");
          // });
        } else {
          setState(() {
            nidIndex2 = all.indexWhere(
              (element) => (element.toLowerCase() == "nid no"),
            );
            if (all.length - 1 > nidIndex2) {
              nid = all[nidIndex2 + 1];

              print("2  $nid");
            }
            if (all.length - 1 == nidIndex2) {
              nid = all[nidIndex2 - 1];
              print("1  $nid");
            }
          });

          // if (all.length - 1 <= nidIndex2 + 2) {
          //   setState(() {
          //     nid = all[nidIndex2 + 2];
          //   });
          //   print("0  ${all[nidIndex2 + 1]}");
          // }
        }

        // final nidIndex2 = all.indexWhere(
        //   (element) => (element == "NID NO."),
        // );
        // print(nidIndex);
        // print(nidIndex2);

        // if (all.contains("NID No.")) {

        // } else {
        //   var nidl = scannedText2.split("NID No.");
        //   final nidIndex = nidl.indexWhere(
        //     (element) => (element == "NID No."),
        //   );
        //   if (nidIndex == nidl.length - 1) {
        //     setState(() {
        //       nid = nidl[nidIndex - 1];
        //     });
        //     print("2${nidl[nidIndex - 1]}");
        //   }
        //   if (nidIndex - 1 == nidl.length - 1) {
        //     setState(() {
        //       nid = nidl[nidIndex + 1];
        //     });
        //     print("1${nidl[nidIndex + 1]}");
        //   }
        // }

        // print("nid  ${all[(all.length - 3)]}");
        // print(all);
        // var nidL = scannedText.split("ID NO.");
        // var namL = scannedText.split("Name");
        // // var date = l.sublist(1).join('\n').trim();
        // var nidl = nidL[1].split("\n");
        // var namel = namL[1].split("\n");
        // print("sp list ${nidl}");
        // print("sp lsi ${namel}");

      }
    } else {
      print("totalL id none");
      return "Please choose clear nid photo";
    }

    // prefix[0];

    textScanning = false;
    setState(() {});
    return {"name": name, "nid": nid};
  }
}
