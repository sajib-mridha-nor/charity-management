import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/model/contact_response.dart';
import 'package:donation_tracker/pages/donate_history_page.dart';
import 'package:donation_tracker/pages/search/search_page_controller.dart';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:donation_tracker/widget/people_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late SearchBar searchBar;
  final controller = Get.put(SearchPageController());

  AppBar buildAppBar(BuildContext context) {
    return AppBar(title: const Text("Search"),
        // backgroundColor: Color.fromARGB(255, 147, 192, 244),
        actions: [
          searchBar.getSearchAction(context),
        ]);
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
  void dispose() {
    controller.dispose();
    // controller.pagingController.dispose();
    // controller.pagingController.refresh();
    // TODO: implement dispose
    super.dispose();
  }

  void onSubmitted(String value) {
    controller.query(value);
    controller.pagingController.refresh();
  }

  @override
  void initState() {
    searchBar = SearchBar(
        inBar: true,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        clearOnSubmit: false,
        closeOnSubmit: false,
        onCleared: () {
          debugPrint("Search bar has been cleared");
        },
        onClosed: () {
          debugPrint("Search bar has been closed");
        });
    Future.delayed(const Duration(milliseconds: 500), () {
      searchBar.beginSearch(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      backgroundColor: HexColor("f2f2f2"),
      key: _scaffoldKey,
      appBar: searchBar.build(context),
      body: Padding(
        padding: EdgeInsets.only(right: 8, left: 8, top: 8),
        child: PagedListView<int, Contact>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Contact>(
              itemBuilder: (context, item, index) => PeopleCard(
                    name: item.name.toString(),
                    nid: item.nidBirth.toString(),
                    image: item.image,
                    phone: item.mobile.toString(),
                    union:
                        _union[int.parse(item.union.toString()) - 4].toString(),
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
                              id: item.id.toString()),
                          arguments: {"c_id": item.id});
                    },
                    onDonate: () {
                      Get.to(
                          () => DonationFormPage(
                                name: item.name,
                              ),
                          arguments: {"c_id": item.id});
                    },
                  )),
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 8.0,
          //     mainAxisSpacing: 0,
          //     mainAxisExtent: 150),
        ),
      ),
    );
  }
}
