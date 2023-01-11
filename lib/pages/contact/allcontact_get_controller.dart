import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/model/contact_response.dart';
import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllcontractGetController extends GetxController {
  RxString query = "".obs;

  final dioClient = DioClient(BASE_URL, Dio());
  static const _pageSize = 15;
  GetStorage box = GetStorage();

  final PagingController<int, Contact> pagingController =
      PagingController(firstPageKey: 1);
  var res;
  var pagination;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.onInit();
  }

  Future<void> _fetchPage(int pageKey) async {
    var token = GetStorage().read("token");
    try {
      print("object");

      res = await http.get(
          Uri.parse(
              "https://ezze.dev/donation/api/v1/contacts?limit=$_pageSize&page=$pageKey"),
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'authorization': 'Bearer $token',
          });
      // final res = await Dio().get(
      //     "https://ezze.dev/donation/api/v1/contacts/$query?limit=$_pageSize&page=$pageKey",
      //     options: Options(
      //         headers: {"authorization": box.read("token").toString()}));
      print("obc $res");
      print("obcc $res");
      print("obct ${res.body}");

      // final r = json
      //     .decode(res.body)
      //     .map<String, dynamic>((x) => ContactResponse.fromJson(x));
      // print("ob ${r}");
// final res = await http.Response.fromStream(response);
      pagination = ContactResponse.fromJson(json.decode(res.body));
      if (pagination.nextPageUrl == null) {
        pagingController.appendLastPage(pagination.contact ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(pagination.contact ?? [], nextPageKey);
      }
    } catch (e) {
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      pagingController.error = message;
      print("obct $e");
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
