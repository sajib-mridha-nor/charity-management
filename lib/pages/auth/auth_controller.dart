import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AuthController extends GetxController {
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();

  Map<String, dynamic> map = {};
  RxBool isLoading = false.obs;

  login() async {
    try {
      isLoading(true);
      final formData = dio.FormData.fromMap(map);

      final res = await dioClient.post("login", data: formData);
      box.write("token", res["token"]);
      box.write("profile", res);

      print("ff $res");
      Get.snackbar(
        "Succeful",
        "Succeful Loging ",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(HomePage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      Get.snackbar(
        "Try againg",
        "$message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  registration() async {
    try {
      isLoading(true);
      final formData = dio.FormData.fromMap(map);

      final res = await dioClient.post("register", data: formData);

      box.write("token", res["token"]);
      box.write("profile", res);
      print("ff $res");
      Get.snackbar(
        "Succeful",
        "Succeful registation ",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(HomePage());
      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      Get.snackbar(
        "Try againg",
        "$message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
