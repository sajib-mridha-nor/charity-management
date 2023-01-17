import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/pages/model/contact_response.dart';
import 'package:donation_tracker/pages/model/home_page_response.dart';
import 'package:donation_tracker/pages/model/union_model.dart';
import 'package:donation_tracker/utils/constants.dart';
import 'package:donation_tracker/utils/network/dio_client.dart';
import 'package:donation_tracker/utils/network/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UnionController extends GetxController with StateMixin<List<Union>> {
  final dioClient = DioClient(BASE_URL, Dio());

  RxBool isLoading = false.obs;
  RxString unionId = "".obs;
  // Union? UnionData;
  List<Union>? unionData;
  List<Contact>? unionList;

  @override
  void onInit() {
    FatchUnionData();

    super.onInit();
  }

  FatchUnionData() async {
    try {
      change(null, status: RxStatus.loading());

      final unionRes = await dioClient.get(
        "union",
      );

      unionData = UnionModel.fromJson(unionRes).data;

      print("union ${unionRes}");

      change(unionData, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
    }
  }

  FatchuUionContactData() async {
    print("uniondd $unionId");
    try {
      isLoading(true);

      final unionRes = await dioClient.get(
        "contacts/unionwise/$unionId",
      );

      unionList = ContactResponse.fromJson(unionRes).contact;

      print("contacts/unionwise/$unionId");

      isLoading(false);
    } catch (e) {
      isLoading(false);
      var error = NetworkExceptions.getDioException(e);
      var message = NetworkExceptions.getErrorMessage(error);
    }
  }
}
