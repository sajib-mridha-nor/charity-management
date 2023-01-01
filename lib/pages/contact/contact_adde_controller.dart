import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:donation_tracker/pages/donation_form_page.dart';
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

  // final PagingController<int, Content> pagingController =
  // PagingController(firstPageKey: 1);

  @override
  void onInit() {
    // pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });

    super.onInit();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final res = await dioClient.get("contacts");
      // final res = await dioClient.get(
      //     "contents?limit=$_pageSize&page=$pageKey&query=${query.value}");
      // final pagination = ContentPaginationResponse.fromJson(res);
      // if (pagination.nextPageUrl == null) {
      //   pagingController.appendLastPage(pagination.data ?? []);
      // } else {
      //   final nextPageKey = pageKey + 1;
      //   pagingController.appendPage(pagination.data ?? [], nextPageKey);
      // }
    } catch (e) {
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      // pagingController.error = message;
    }
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
      print(res.body);

      // map["nid_image"] =
      //     await http.MultipartFile.fromBytes(image.bytes!, {filename: basename(image),});
      print("nid_image v ");
      // final formData = dio.FormData.fromMap(map);

      // final res = await http.post(url, headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // });
      print('Token : ${token}');

      print("formData v ");
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
      print("dioClient v ");

      // print("ff $res");
      Get.off(HomePage());
      isLoading(false);
    } catch (e) {
      print("catch v $e");

      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      print(message);
    }
  }

  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
