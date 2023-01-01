import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/donation_form_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/pages/model/home_page_response.dart';
import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageController extends GetxController with StateMixin<HomeData> {
  final dioClient = DioClient(BASE_URL, Dio());

  RxBool isLoading = false.obs;
  HomeData? homeData;

  @override
  void onInit() {
    homePagaData();

    super.onInit();
  }

  homePagaData() async {
    try {
      change(null, status: RxStatus.loading());

      final res = await dioClient.get(
        "total",
      );
      homeData = HomeData.fromJson(res);

      print("ff ${res}");
      change(homeData, status: RxStatus.success());
    } catch (e) {
      change(homeData, status: RxStatus.error());
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
    }
  }
}