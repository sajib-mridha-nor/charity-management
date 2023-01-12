import 'package:donation_tracker/pages/contact/allcontact.dart';
import 'package:donation_tracker/pages/contact/contact_form.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:donation_tracker/pages/auth/registration_page.dart';
import 'package:donation_tracker/pages/donate_history_page_controller.dart';
import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/homepage_controller.dart';
import 'package:donation_tracker/pages/donate_history_page.dart';
import 'package:donation_tracker/pages/auth/login_page.dart';
import 'package:donation_tracker/pages/sceene_reader.dart/sceen_reader.dart';
import 'package:donation_tracker/pages/search/search_page.dart';
import 'package:donation_tracker/pages/search/search_page_controller.dart';
import 'package:donation_tracker/pages/search/union_page.dart';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:donation_tracker/widget/statistics_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  GetStorage box = GetStorage();
  final controller = Get.put(HomePageController());
  Future<void> _pullRefresh() async {
    controller.homePagaData();
  }

  var sliderImg = [
    "assets/polak/polak1.jpg",
    "assets/polak/polak2.jpg",
    "assets/polak/polak3.jpg",
    "assets/polak/polak4.jpg",
    "assets/polak/polak5.jpg",
    "assets/polak/polak6.jpeg",
    "assets/polak/polak7.png",
    "assets/polak/polak8.png",
  ];

  @override
  Widget build(BuildContext context) {
    final profile = box.read("profile");
    return controller.obx((state) => Scaffold(
          drawer: SafeArea(
            child: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.5),
                    ),
                    accountName: Text(profile["user"]["name"] ?? ''),
                    accountEmail: Text(profile["user"]["email"] ?? ""),
                    currentAccountPicture: CircleAvatar(
                      // backgroundColor: Colors.orange,
                      child: Text(
                        profile["user"]["name"].substring(0, 1) ?? '',
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text("Contact Us"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.logout),
                  //   title: Text("Log out"),
                  //   onTap: () {
                  //     Get.offAll(LoginPage());
                  //     box.remove("profile");
                  //     box.remove("token");
                  //     // Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          // backgroundColor: Color(0xFFADC6E3),
          backgroundColor: HexColor("b9e0ff"),
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 147, 192, 244),
            centerTitle: true,
            title: const Text(
              "Charity Management",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (() {
                    Get.to(SearchPage());
                  }),
                  icon: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.2),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      )))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CarouselSlider(
                          items: List.generate(8, (index) {
                            final item = sliderImg[index];
                            return GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  "$item",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          }),
                          options: CarouselOptions(
                              autoPlay: true,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              viewportFraction: .99,
                              aspectRatio: 1.5,
                              autoPlayInterval: const Duration(seconds: 10),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true)),
                      // Center(
                      //   child: Container(
                      //     // height: 200,
                      //     // width: 200,
                      //     child: Image.asset("assets/row-image-adviser.png"),
                      //   ),
                      // ),
                      // Center(
                      //   child: Container(
                      //     height: 300,
                      //     // width: 200,
                      //     child: Image.asset("assets/row-image-pm.png"),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Positioned.fill(
                        bottom: -160,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            color: HexColor("b9e0ff"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )),
                            child: SizedBox(
                              height: 190,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        // Get.to(LoginPage());
                                      }),
                                      child: Totals(
                                          offeset: Offset(0, 0),
                                          height: 150,
                                          width: 120,
                                          icon: "assets/bangladesh.png",
                                          title: "Total Union",
                                          caption: controller.unionData?.length
                                                  .toString() ??
                                              ""),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: (() {
                                            // Get.to(LoginPage());
                                          }),
                                          child: Totals(
                                              offeset: Offset(0, 0),
                                              height: 70,
                                              width: 180,
                                              imgH: 18,
                                              imgW: 18,
                                              icon: "assets/charity.png",
                                              title: "Total Contacts",
                                              caption:
                                                  state!.contacts.toString()),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        GestureDetector(
                                          onTap: (() {}),
                                          child: Totals(
                                              offeset: Offset(0, 0),
                                              height: 70,
                                              width: 180,
                                              imgH: 12,
                                              imgW: 12,
                                              icon: "assets/donation.png",
                                              title: "Total Donates",
                                              caption:
                                                  state.donates.toString()),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 160,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Get.to(AllContactShowPage());
                        }),
                        child: StatisticWidget2(
                            height: 120,
                            width: double.infinity,
                            icon: "assets/c.png",
                            title: "People List",
                            caption: ""),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (() {
                                  Get.to(ContactForm());
                                }),
                                child: const StatisticWidget2(
                                    height: 120,
                                    width: 170,
                                    icon: "assets/l.png",
                                    title: "Add People",
                                    caption: " "),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (() {
                                  Get.to(UnionPage());
                                }),
                                child: StatisticWidget2(
                                    height: 120,
                                    width: 170,
                                    icon: "assets/union.jpeg",
                                    title: "Search by Union ",
                                    caption: ""),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),

                  // GestureDetector(
                  //   onTap: (() {
                  //     Get.to(LoginPage());
                  //   }),
                  //   child: Totals(
                  //       height: 100,
                  //       width: double.infinity,
                  //       icon: "assets/h.png",
                  //       title: "Total Donates history",
                  //       caption: ""),
                  // ),

                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
