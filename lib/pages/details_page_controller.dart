import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/model/donate_get_response.dart';
import 'package:http/http.dart' as http;

import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DetailsPageController extends GetxController
    with StateMixin<List<Donate>> {
  final dioClient = DioClient(BASE_URL, Dio());
  GetStorage box = GetStorage();
  var donatio;

  @override
  void onInit() {
    GetDonationLsit();

    super.onInit();
  }

  GetDonationLsit() async {
    var token = GetStorage().read("token");
    print("ff ${GetStorage().read("token")}");
    try {
      change(null, status: RxStatus.loading());

      // var request = http.MultipartRequest(
      //   'POST',
      //   postUri,
      // );
      // request.fields.addAll(map);
      // request.headers['authorization'] = 'Bearer $token';

      // var multipartFile = await http.MultipartFile.fromPath(
      //     'nid_image', image); //returns a Future<MultipartFile>
      // request.files.add(multipartFile);
      // var response = await request.send();
      // final res = await http.Response.fromStream(response);
      // print(res.body);

      // // map["nid_image"] =
      // //     await http.MultipartFile.fromBytes(image.bytes!, {filename: basename(image),});
      // print("nid_image v ");
      // final formData = dio.FormData.fromMap(map);

      // final res = await http.post(url, headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // });
      print('Token : ${token}');

      print("formData v ");
      final res = await dioClient.get(
        "donates",

        // options:
        //     Options(headers: {"authorization": box.read("token").toString()}),
      );
      donatio = DonateGetResponse.fromJson(res).data;

      // final res = await Dio().post("https://ezze.dev/donation/api/v1/contacts",
      //     data: formData,
      //     options: Options(
      //         headers: {"authorization": box.read("token").toString()}));
      print("dioClient v$donatio ");

      // print("ff $res");

      change(donatio, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
      print("catch v $e");

      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
      print(message);
    }
  }
}
