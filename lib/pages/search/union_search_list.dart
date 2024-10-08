import 'package:donation_tracker/pages/contact/allcontact_get_controller.dart';
import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/model/contact_response.dart';
import 'package:donation_tracker/pages/donate_history_page.dart';
import 'package:donation_tracker/pages/search/search_page.dart';
import 'package:donation_tracker/pages/search/search_page_controller.dart';
import 'package:donation_tracker/pages/search/union_controlller.dart';
import 'package:donation_tracker/widget/people_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UnionContactShowPage extends StatefulWidget {
  const UnionContactShowPage({Key? key}) : super(key: key);

  @override
  State<UnionContactShowPage> createState() => _UnionContactShowPageState();
}

class _UnionContactShowPageState extends State<UnionContactShowPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late SearchBar searchBar;
  final controller = Get.put(UnionController());

  @override
  void initState() {
    super.initState();
  }

  List<String> _union = [
    "Sukash",
    "Dahia",
    "Italy",
    "Kalam",
    "Chamari",
    "Hatiandaha",
    "Lalore",
    "Sherkole",
    "Tajpur",
    "Chaugram",
    "Chhatardighi",
    "Ramananda khajura",
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Union people list",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
          ),
          centerTitle: true,
          // backgroundColor: Color.fromARGB(255, 147, 192, 244),
          actions: [
            IconButton(
                onPressed: (() {
                  Get.to(SearchPage());
                }),
                icon: Icon(Icons.search))
          ],
        ),
        body: Obx(
          (() => Padding(
              padding: EdgeInsets.only(right: 8, left: 8, top: 8),
              child: controller.isLoading.value == true
                  ? Center(child: CircularProgressIndicator())
                  : controller.unionList?.length == 0
                      ? Center(
                          child: Text("Data is not found"),
                        )
                      : ListView.builder(
                          itemCount: controller.unionList?.length,
                          itemBuilder: ((context, index) {
                            final item = controller.unionList?[index];
                            return controller.unionList?.length == 0
                                ? Text("No Data found")
                                : PeopleCard(
                                    name: item?.name.toString(),
                                    nid: item?.nidBirth.toString(),
                                    image: item?.image,
                                    phone: item?.mobile.toString(),
                                    union: _union[
                                            int.parse(item!.union.toString()) -
                                                4]
                                        .toString(),
                                    onClick: () {
                                      print(item.id);
                                      Get.to(
                                          () => PeopleDetailsPage(
                                                gender: item.gender,
                                                name: item.name,
                                                phone: item.mobile,
                                                nid: item.nidBirth,
                                                image: item.image,
                                                union: item.union,
                                                id: _union[int.parse(item.union
                                                            .toString()) -
                                                        4]
                                                    .toString(),
                                              ),
                                          arguments: {"c_id": item.id});
                                    },
                                    onDonate: () {
                                      Get.to(
                                          () => DonationFormPage(
                                                name: item.name,
                                              ),
                                          arguments: {"c_id": item.id});
                                    },
                                  );
                          })))),
        ));
  }
}
