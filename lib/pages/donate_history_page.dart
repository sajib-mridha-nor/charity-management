import 'dart:ffi';

import 'package:donation_tracker/pages/donate_history_page_controller.dart';
import 'package:donation_tracker/pages/donation/donation_form_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:timelines/timelines.dart';

class PeopleDetailsPage extends StatelessWidget {
  final String? name;
  final String? gender;
  final String? nid;
  final String? phone;
  final String? union;
  final String? id;

  final String? image;
  PeopleDetailsPage(
      {super.key,
      this.gender,
      this.image,
      this.id,
      this.name,
      this.nid,
      this.phone,
      this.union});

  final controller = Get.put(DetailsPageController());

  Future<void> _onRefresh() async {
    controller.getDonationLsit();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: HexColor("#f2f2f2"),
        // backgroundColor: Color.fromARGB(219, 201, 224, 244),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(HomePage());
                },
                icon: Icon(Icons.home))
          ],
          title: Text(
            "Details page",
          ),
          centerTitle: true,
          // backgroundColor: Colors.blue.withOpacity(.5),
        ),
        body: controller.obx((state) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: image == null
                                    ? CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            "assets/pngwing.com.png"))
                                    : CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            "https://ezze.dev/donation/" +
                                                image.toString()))),
                            SizedBox(
                              height: 4,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name ?? "Abul Fazal Mia",
                                    style: textTheme.titleMedium
                                        ?.copyWith(color: Colors.black)),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("NID: ",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("Phone:",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("Gender:",
                                            textAlign: TextAlign.end,
                                            style:
                                                textTheme.bodyMedium?.copyWith(
                                              color: Colors.black,
                                            )),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("Union: ",
                                            style: textTheme.bodyMedium
                                                ?.copyWith()),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${(nid ?? "1234567890")}",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("${phone ?? "017xxxxxxx"}",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("${gender ?? ""}",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("${union ?? "Firuzpur"}",
                                            style: textTheme.bodyMedium
                                                ?.copyWith()),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                                // height: 20,
                                // width: 80,
                                child: ElevatedButton(
                                    onPressed: (() {
                                      Get.to(DonationFormPage(name: name),
                                          arguments: {"c_id": id});
                                    }),
                                    child: Text("Donate")))
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 1,
                        //     blurRadius: 1,
                        //     offset: Offset(0, 2), // changes position of shadow
                        //   ),
                        // ],
                        color: HexColor("#D6DFFF"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total donation:",
                                style: textTheme.titleMedium?.copyWith()),
                            Text("${state?.length}",
                                style: textTheme.titleMedium?.copyWith()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // Divider(
                //   height: 2,
                //   thickness: 1,
                // ),

                state!.isEmpty
                    ? Center(
                        child: Text("No Data found"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(state.length, (index) {
                          final item = state[index];

                          return Column(
                            children: [
                              DonationCard(
                                amount: item.amount.toString(),
                                date: item.donationDate.toString(),
                                details: item.description.toString(),
                                image: item.image,
                                name: item.itemName.toString(),
                                quantity: item.quantity.toString(),
                              ),
                              index == state.length - 1
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.blue,
                                      ),
                                    )
                            ],
                          );
                        }),
                      )
              ]),
            ),
          );
        }));
  }
}

class DonationCard extends StatelessWidget {
  final String? name;
  final String? date;
  final String? amount;
  final String? quantity;
  final String? details;
  final int? l;
  final List<String>? image;

  const DonationCard(
      {Key? key,
      this.amount,
      this.l,
      this.date,
      this.details,
      this.image,
      this.name,
      this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //   HexColor("#83EAF1").withOpacity(.1),
              //   HexColor("#63A4FF").withOpacity(.1),
              // ])

              ),
          child: Row(
            children: [
              SizedBox(
                // height: 356,
                width: MediaQuery.of(context).size.width - 16,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Item",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Amount",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Quantity",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 32,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$date",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "$name",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "${amount == null ? 0 : amount}",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    // SizedBox(
                                    //   height: 2,
                                    // ),
                                    Text(
                                      "${quantity == null ? 0 : quantity}",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Details: ",
                              style: textTheme.bodyText2
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              // height: 60,
                              // width: 400,
                              child: Text(
                                "$details",
                                // textAlign: TextAlign.justify,
                                style: textTheme.bodyText2?.copyWith(),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Image",
                              style: textTheme.bodyText2
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 200,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: image == null
                                      ? List.generate(
                                          1,
                                          (index) => Image.asset(
                                                "assets/charity.png",
                                                height: 100,
                                              ))
                                      : List.generate(
                                          image!.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  "https://ezze.dev/donation/" +
                                                      image![index].toString(),
                                                  height: 250,
                                                  width: 100,
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}
