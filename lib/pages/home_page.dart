import 'package:donation_tracker/pages/contact/contact_form.dart';

import 'package:donation_tracker/pages/auth/registration_page.dart';
import 'package:donation_tracker/pages/details_page_controller.dart';
import 'package:donation_tracker/pages/donation_form_page.dart';
import 'package:donation_tracker/pages/people_details_page.dart';
import 'package:donation_tracker/pages/auth/login_page.dart';
import 'package:donation_tracker/pages/search/search_page.dart';
import 'package:donation_tracker/pages/search/search_page_controller.dart';
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
  final searhController = Get.put(SearchPageController());
  final detailsController = Get.put(DetailsPageController());

  @override
  Widget build(BuildContext context) {
    final profile = box.read("profile");
    return Scaffold(
      drawer: Drawer(
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
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () {
                Get.offAll(LoginPage());
                box.remove("profile");
                box.remove("token");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(219, 201, 224, 244),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue.withOpacity(.5),
        centerTitle: true,
        title: const Text(
          "Charity Management",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(SearchPage());
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          // Center(
          //   child: Container(
          //     // height: 200,
          //     // width: 200,
          //     child: Image.asset("assets/row-image-adviser.png"),
          //   ),
          // ),
          Center(
            child: Container(
              height: 300,
              // width: 200,
              child: Image.asset("assets/row-image-pm.png"),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: (() {
                  Get.to(ContactForm());
                }),
                child: const StatisticWidget(
                    height: 150,
                    width: 300,
                    icon: "assets/charity.png",
                    title: "Add new People",
                    caption: " "),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: (() {
                  Get.to(PeopleDetailsPage());
                }),
                child: StatisticWidget(
                    height: 150,
                    width: 300,
                    icon: "assets/donation.png",
                    title: "See List of people",
                    caption: ""),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: GestureDetector(
          //         onTap: (() {
          //           Get.to(LoginPage());
          //         }),
          //         child: StatisticWidget(
          //             height: 150,
          //             width: 200,
          //             icon: "assets/charity.png",
          //             title: "Add new Donar",
          //             caption: ),
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Expanded(
          //       child: GestureDetector(
          //         onTap: (() {

          //         }),
          //         child: StatisticWidget(
          //             height: 150,
          //             width: 200,
          //             icon: "assets/donation.png",
          //             title: "Total donation",
          //             caption:
          //                 "detailsController.donatio.length.toString() ?? " ""),
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
