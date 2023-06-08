import 'dart:io';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:mime/mime.dart';

class CustomFilePicker extends StatefulWidget {
  // final XFile? initialize;
  final String? label;
  final TextStyle? labelStyle;
  final String hint;
  final String? error;
  final bool? require;
  final Function(File file) onChange;
  final Icon? endIcon;
  final List<String>? allowedExtensions;
  final double? maxFileSize;

  const CustomFilePicker(
      {Key? key,
      this.label,
      // this.initialize,
      required this.hint,
      this.error,
      this.require,
      required this.onChange,
      this.labelStyle,
      this.endIcon,
      this.allowedExtensions,
      this.maxFileSize})
      : super(key: key);

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  final _inputController = TextEditingController();
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  List<File> image = [];
  List<XFile?>? pickedFile;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: widget.allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      final int sizeInBytes = file.lengthSync();
      final double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > (widget.maxFileSize ?? 2)) {
        Get.snackbar(
          "File is too big",
          "File size must be less than ${(widget.maxFileSize ?? 2)}MB",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        //set file name
        _inputController.text = basename(file.path);
        widget.onChange(file);
        setState(() {
          image[0] = file;
        });
      }
    } else {
      // User canceled the picker
    }
  }

  void _pickFileMultiple() async {
    // _inputController.text = widget.initialize!.path;
    pickedFile = await ImagePicker()
        .pickMultiImage(maxHeight: 800, maxWidth: 800, imageQuality: 40);
    // source: ImageSource
    //     .camera); //This opens the gallery and lets the user pick the image
    if (pickedFile == null) return;
    //Checks if the user did actually pick something
    pickedFile?.forEach((element) {
      image.add(File(element!.path));
    });
    _inputController.text = basename(image[0].path);
    image.forEach((element) {
      widget.onChange(element);
    });
    setState(() {
      _selectedFile = File(image[0].path);
    });
    print(image);
  }

  void _pickFileCamera() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1000,
        imageQuality: 40);
    print("picker fff$pickedFile");

    if (pickedFile == null) return;

    image.add(File(pickedFile.path));
    print("picker fff$image");
    // image.forEach((element) {
    //   widget.onChange(element);
    // });

    _inputController.text = basename(image[0].path);
    widget.onChange(image[0]);
    setState(() {
      _selectedFile = File(pickedFile.path);
    });
    print(image);
  }

  _openDialog() {
    return Get.defaultDialog(
      barrierDismissible: true,
      textCustom: "Camera",
      contentPadding: const EdgeInsets.all(16),
      titlePadding: const EdgeInsets.only(top: 16),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: (() {
                _pickFileCamera();
                Get.back();
              }),
              icon: const Icon(CupertinoIcons.camera),
              label: const Text("Camera")),
          const SizedBox(
            width: 16,
          ),
          ElevatedButton.icon(
              onPressed: (() {
                Get.back();
                _pickFileMultiple();
                print("object");
              }),
              icon: const Icon(CupertinoIcons.photo_fill),
              label: const Text("Gallery"))
        ],
      ),
      title: "Choose image source ",
      titleStyle: const TextStyle(color: Colors.black),
      custom: const Text("data"),
    );
  }

  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    // widget.initialize == null
    //     ? null
    //     : _inputController.text = basename(widget.initialize!.path);

    // widget.initialize == null ? null : image.add(File(widget.initialize!.path));
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // widget.label != ""
        //     ? Column(
        //         children: [
        //           RichText(
        //             text: TextSpan(
        //               text: widget.label,
        //               style: widget.labelStyle ??
        //                   DefaultTextStyle.of(context).style,
        //               children: <TextSpan>[
        //                 // widget.require == null || widget.require == true
        //                 //     ? const TextSpan(
        //                 //         text: '', style: TextStyle(color: Colors.red))
        //                 //     : const TextSpan(),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 4,
        //           ),
        //         ],
        //       )
        //     : Container(),
        TextFormField(
          onTap: () {
            setState(() {
              FocusScope.of(context).requestFocus(myFocusNode);
            });
          },
          focusNode: myFocusNode,
          controller: _inputController,
          showCursor: false,
          readOnly: true,
          validator: (value) {
            if (widget.require == false) {
              return null;
            }
            if (value == null || value.isEmpty) {
              if (widget.error == null) {
                return widget.hint;
              }
              return widget.error;
            }
            return null;
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: widget.hint,
              hintStyle: textTheme.caption?.copyWith(fontSize: 16),
              labelText: widget.hint,
              labelStyle: textTheme.caption?.copyWith(
                  fontSize: 16,
                  color: myFocusNode.hasFocus
                      ? HexColor("#3d8ede").withOpacity(.6)
                      : Colors.black54),
              suffixIcon: IconButton(
                  onPressed: () {
                    _openDialog();
                    // _pickFile();
                  },
                  icon: widget.endIcon ??
                      Icon(
                        Icons.camera,
                        size: 30,
                        color: HexColor("#3d8ede"),
                      )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 2, color: HexColor("#3d8ede").withOpacity(.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 2, color: HexColor("#3d8ede").withOpacity(.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 2, color: HexColor("#3d8ede").withOpacity(.5)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
        ),
        Container(
          child: _selectedFile != null && isImage(_selectedFile!.path)
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      image.length,
                      (index) => imageView(selectedFile: image[index]),
                    ),
                  ),
                )
              : null,
        )
      ],
    );
  }
}

class imageView extends StatelessWidget {
  const imageView({
    Key? key,
    required File? selectedFile,
  })  : _selectedFile = selectedFile,
        super(key: key);

  final File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(6.0)),
        child: Center(
          child: Image.file(_selectedFile!),
        ),
      ),
    );
  }
}

bool isImage(String path) {
  final mimeType = lookupMimeType(path);
  return mimeType!.startsWith('image/');
}

class CustomFilePicker2 extends StatefulWidget {
  final XFile? initialize;
  final String? label;
  final TextStyle? labelStyle;
  final String hint;
  final String? error;
  final bool? require;
  final Function(File file) onChange;
  final Icon? endIcon;
  final List<String>? allowedExtensions;
  final double? maxFileSize;

  const CustomFilePicker2(
      {Key? key,
      this.label,
      this.initialize,
      required this.hint,
      this.error,
      this.require,
      required this.onChange,
      this.labelStyle,
      this.endIcon,
      this.allowedExtensions,
      this.maxFileSize})
      : super(key: key);

  @override
  State<CustomFilePicker2> createState() => _CustomFilePicker2State();
}

class _CustomFilePicker2State extends State<CustomFilePicker2> {
  final _inputController = TextEditingController();
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();
  File? image;
  List<XFile?>? pickedFile;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: widget.allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      final int sizeInBytes = file.lengthSync();
      final double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > (widget.maxFileSize ?? 4)) {
        Get.snackbar(
          "File is too big",
          "File size must be less than ${(widget.maxFileSize ?? 4)}MB",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        //set file name
        _inputController.text = basename(file.path);
        widget.onChange(file);
        setState(() {
          image = file;
        });
      }
    } else {
      // User canceled the picker
    }
  }

  void _pickFileMultiple() async {
    _inputController.text = widget.initialize!.path;
    pickedFile = await ImagePicker()
        .pickMultiImage(maxHeight: 800, maxWidth: 800, imageQuality: 40);
    // source: ImageSource
    //     .camera); //This opens the gallery and lets the user pick the image
    if (pickedFile == null) return;
    //Checks if the user did actually pick something
    // pickedFile?.forEach((element) {
    //   image.add(File(element!.path));
    // });
    setState(() {
      image = File(pickedFile![0]!.path);
      _inputController.text = basename(image!.path);
      // image.forEach((element) {
      //   widget.onChange(element);
      // });
      widget.onChange(image!);
      _selectedFile = File(image!.path);
    });

    print(image);
  }

  void _pickFileCamera() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1200,
        maxWidth: 1000,
        imageQuality: 40);
    print("picker fff$pickedFile");

    if (pickedFile == null) return;

    setState(() {
      image = (File(pickedFile.path));
      print("picker fff$image");
      _inputController.text = basename(image!.path);
      widget.onChange(image!);
      _selectedFile = File(pickedFile.path);
    });
  }

  _openDialog() {
    return Get.defaultDialog(
      barrierDismissible: true,
      textCustom: "Camera",
      contentPadding: const EdgeInsets.all(16),
      titlePadding: const EdgeInsets.only(top: 16),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: (() {
                _pickFileCamera();
                Get.back();
              }),
              icon: const Icon(CupertinoIcons.camera),
              label: const Text("Camera")),
          const SizedBox(
            width: 16,
          ),
          ElevatedButton.icon(
              onPressed: (() {
                Get.back();
                _pickFile();
                print("object");
              }),
              icon: const Icon(CupertinoIcons.photo_fill),
              label: const Text("Gallery"))
        ],
      ),
      title: "Choose image source ",
      titleStyle: const TextStyle(color: Colors.black),
      custom: const Text("data"),
    );
  }

  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    widget.initialize == null
        ? null
        : _inputController.text = basename(widget.initialize!.path);

    widget.initialize == null ? null : image = (File(widget.initialize!.path));
    widget.initialize == null ? null : widget.onChange(image!);
    widget.initialize == null
        ? null
        : _selectedFile = (File(widget.initialize!.path));
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // widget.label != ""
        //     ? Column(
        //         children: [
        //           RichText(
        //             text: TextSpan(
        //               text: widget.label,
        //               style: widget.labelStyle ??
        //                   DefaultTextStyle.of(context).style,
        //               children: <TextSpan>[
        //                 // widget.require == null || widget.require == true
        //                 //     ? const TextSpan(
        //                 //         text: '', style: TextStyle(color: Colors.red))
        //                 //     : const TextSpan(),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 4,
        //           ),
        //         ],
        //       )
        //     : Container(),
        TextFormField(
          onTap: () {
            setState(() {
              FocusScope.of(context).requestFocus(myFocusNode);
            });
          },
          focusNode: myFocusNode,
          controller: _inputController,
          showCursor: false,
          readOnly: true,
          validator: (value) {
            if (widget.require == false) {
              return null;
            }
            if (value == null || value.isEmpty) {
              if (widget.error == null) {
                return widget.hint;
              }
              return widget.error;
            }
            return null;
          },
          decoration: InputDecoration(
              isDense: true,
              hintText: widget.hint,
              hintStyle: textTheme.caption?.copyWith(fontSize: 16),
              labelText: widget.hint,
              labelStyle: textTheme.caption?.copyWith(
                  fontSize: 16,
                  color: myFocusNode.hasFocus
                      ? HexColor("#3d8ede").withOpacity(.6)
                      : Colors.black54),
              suffixIcon: IconButton(
                  onPressed: () {
                    _openDialog();
                    // _pickFile();
                  },
                  icon: widget.endIcon ??
                      Icon(
                        Icons.camera,
                        size: 30,
                        color: HexColor("#3d8ede"),
                      )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 2, color: HexColor("#3d8ede").withOpacity(.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 2, color: HexColor("#3d8ede").withOpacity(.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    width: 2, color: HexColor("#3d8ede").withOpacity(.5)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
        ),
        Container(
          child: widget.initialize != null || image != null
              ? imageView(selectedFile: image)
              : null,
        )
      ],
    );
  }
}
