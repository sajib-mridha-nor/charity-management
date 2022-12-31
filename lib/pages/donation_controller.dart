import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/donation_form_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DonationController extends GetxController {
  final dioClient = DioClient(BASE_URL, Dio());
  final id = Get.arguments["c_id"];

  Map<String, dynamic> map = {};
  List images = [];
  var image;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  postDonation() async {
    try {
      isLoading(true);

      map["contact_id"] = id;
      map["image"] =
          await dio.MultipartFile.fromFile(image, filename: basename(image));
      print(map["image"]);

      //  List.generate(
      //     images.length,
      //     (index) async => await dio.MultipartFile.fromFile(
      //         images[index],
      //         filename:basename(images[index]) ));
      final formData = dio.FormData.fromMap(map);
      // final res = await Dio().post("https://ezze.dev/donation/api/v1/donates",
      //     data: formData,
      //     options: Options(headers: {
      //       "Authorization":
      //           "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWY5Zjc5N2U2ODViNTc5NWM2YjAwYzJlYzY0ZTQwMTcxNWQ5ZmI5ZTBhMTM0NTYzZGYzMmQ3NWVjZGQ4MTcyYzA4OGQ1NGVlMzQxMTlkZDciLCJpYXQiOjE2NzIzMDMzNjMuMzE1MjEyLCJuYmYiOjE2NzIzMDMzNjMuMzE1MjE1LCJleHAiOjE3MDM4MzkzNjMuMTgyNjczLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.Jf6fdNSWElf-pUX0hqjCPGEexuKsGy4GafcF3VwuWuKwiM_ES8EFRVHoiPdoZm6xs_qkw0EP4mdO_QpjMyzwEii8OJQ1RUvmmwGWOtAYO4k_eVMpB1Cyh1zQV_e_zOjyesbxIAp9BW-99Pq2XYAp6gT-YpQLYHCYfPN98D_zx1Pft4Chy4G_PouJ9J-CaDbOhNghUP4MhfY7dp1MJxUo_KZD0WFk7c1YXjGQm2LdJlYRNGgiPTHdVA3SC_jU82x4_Mt_3Pl0-J8wD-hHmd3jriWaau4rSdENOBsEtGt8IyS9MFvyR8TrM3OwriAgbgseU0S3lCbf75ApPH0JnoAkw3d3bj6-tpwDFZFpaJAG083lc3OUX3xUYeZjtW_qhQFEb3f2RgbV-A3Y0-2w14ivzVXj5fzRkKo09DoixOA-lb-hXeQP0KmWrFb1ujePniAZbqVNCkHAnIIkJP7cYcHplZY7TX4SOQ8ZWUr7YMwvmI9QHtWxfg557VEb1ixsVly4gz9Mm25iLMr2p06jzMJUGwkUF9_LEAwZaDX29unpRRD0dNMeZUQqiy-XbOVbScwYf6xgGMAlnIA-z7ZFmxL-u9WMwovEt8OTH6vT_4TpCa8QNdcMynHDRLA3xSM9w2lMXqRSrbx73qUBbNHNheBNTRQ3akgOFGgmtLSlRuGsojQ"
      //     }));

      final res = await dioClient.post("donates", data: formData);
      Get.off(HomePage());
      print("ff ${res}");

      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
    }
  }

  @override
  void onClose() {
    // pagingController.dispose();
    super.onClose();
  }
}
