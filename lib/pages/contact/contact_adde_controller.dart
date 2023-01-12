import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/contact/allcontact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContactController extends GetxController {
  RxString query = "".obs;
  var image;
  var profile;

  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();

  static const _pageSize = 15;
  Map<String, String> map = {};
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  postContacts() async {
    var postUri = Uri.parse("https://ezze.dev/donation/api/v1/contacts");
    var url = Uri.https('ezze.dev', '/donation/api/v1/contacts');
    var token = GetStorage().read("token");
    print("ff ${GetStorage().read("token")}");
    try {
      print("ff  ${box.read("token")}");

      isLoading(true);

      var request = http.MultipartRequest(
        'POST',
        postUri,
      );
      request.fields.addAll(map);
      request.headers['authorization'] = 'Bearer $token';

      var multipartFile = await http.MultipartFile.fromPath('nid_image', image);
      var multipartFile2 = await http.MultipartFile.fromPath('image', profile);
      //returns a Future<MultipartFile>
      request.files.add(multipartFile);
      request.files.add(multipartFile2);
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      final resdata = res.body;
      ;
      if (res.statusCode == 200) {
        Get.snackbar(
          "Successful",
          "Submitted Successful, see details list",
          backgroundColor: Colors.green.withOpacity(0.5),
          snackPosition: SnackPosition.BOTTOM,
        );

        // print("ff $res");
        Get.off(AllContactShowPage());
      } else {
        Get.snackbar(
          "This people already exists",
          "Add new phone number and NID/Birth certificate no.",
          backgroundColor: Colors.red.withOpacity(0.5),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      print(res.body);

      // map["nid_image"] =
      //     await http.MultipartFile.fromBytes(image.bytes!, {filename: basename(image),});

      // final formData = dio.FormData.fromMap(map);

      // final res = await http.post(url, headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // });

      // final res = await dioClient.post(
      //   "contacts",
      //   data: formData,
      //   // options:
      //   //     Options(headers: {"authorization": box.read("token").toString()}),
      // );

      // final res = await Dio().post("https://ezze.dev/donation/api/v1/contacts",
      //     data: formData,
      //     options: Options(
      //         headers: {"authorization": box.read("token").toString()}));

      isLoading(false);
    } on SocketException {
      isLoading(false);
      throw Get.snackbar(
        "Fail!!",
        "Plase check your connection",
        backgroundColor: Colors.red.withOpacity(0.5),
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TimeoutException catch (e) {
      isLoading(false);
      Get.snackbar(
        "Fail!!",
        "Try againg, Time out!",
        backgroundColor: Colors.red.withOpacity(0.5),
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Error catch (e) {
      isLoading(false);
      print('Error: $e');
    } catch (e) {
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      print("catch v $e");
      Get.snackbar(
        "Sorry!",
        "$e",
        backgroundColor: Colors.green.withOpacity(0.5),
        snackPosition: SnackPosition.BOTTOM,
      );

      isLoading(false);

      print(message);
    }
  }

  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
