import 'dart:ffi';

import 'package:donation_tracker/pages/details_page_controller.dart';
import 'package:donation_tracker/pages/donation_form_page.dart';
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        // backgroundColor: HexColor("#FAF6F1"),
        // backgroundColor: Color.fromARGB(219, 201, 224, 244),
        appBar: AppBar(
          leading: IconButton(
              onPressed: (() {
                Get.off(() => HomePage());
              }),
              icon: Icon(
                Icons.arrow_back,
              )),
          title: Text(
            "Details page",
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.withOpacity(.5),
        ),
        body: controller.obx((state) {
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: image == null
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        AssetImage("assets/pngwing.com.png"))
                                : CircleAvatar(
                                    radius: 40,
                                    child: CircleAvatar(
                                        radius: 39,
                                        backgroundImage: NetworkImage(
                                            "https://ezze.dev/donation/" +
                                                image.toString())),
                                  ))),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 12,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${name ?? " "}",
                              style: textTheme.bodyText2
                                  ?.copyWith(color: Colors.black)),
                          Text("Gender:  ${gender ?? ""}",
                              style: textTheme.bodyText2
                                  ?.copyWith(color: Colors.black)),
                          Text("NID:  ${nid ?? ""}",
                              style: textTheme.bodyText2
                                  ?.copyWith(color: Colors.black)),
                          Text("Phone:  ${phone ?? ""}",
                              style: textTheme.bodyText2
                                  ?.copyWith(color: Colors.black)),
                          Text("Union:  ${union ?? ""}",
                              style: textTheme.bodyText2
                                  ?.copyWith(color: Colors.black)),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: SizedBox(
                    //     width: 26,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 500,
              //   width: 300,
              //   child: Timeline.tileBuilder(
              //     builder: TimelineTileBuilder.fromStyle(
              //       indicatorStyle: IndicatorStyle.outlined,
              //       itemExtent: 200,
              //       contentsAlign: ContentsAlign.basic,
              //       contentsBuilder: (context, index) => Padding(
              //         padding: const EdgeInsets.all(24.0),
              //         child: Text('${state?[1].donationDate}'),
              //       ),
              //       itemCount: 2,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("Total donation:${state?.length}",
                            style: textTheme.bodyText2
                                ?.copyWith(color: Colors.blue.shade900)),
                      ),
                    ),
                    SizedBox(
                        // height: 20,
                        // width: 80,
                        child: ElevatedButton(
                            onPressed: (() {
                              Get.to(DonationFormPage(name: name),
                                  arguments: {"c_id": id});
                            }),
                            child: Text("Donate"))),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 8,
              // ),
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
                      children: List.generate(state.length, (index) {
                        final item = state[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DonationCard(
                            amount: item.amount.toString(),
                            date: item.donationDate.toString(),
                            details: item.description.toString(),
                            image: item.image,
                            name: item.itemName.toString(),
                            quantity: item.quantity.toString(),
                          ),
                        );
                      }),
                    )
            ]),
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
  final List<String>? image;
  const DonationCard(
      {Key? key,
      this.amount,
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
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        child: Row(
          children: [
            SizedBox(
              height: 350,
              child: TimelineNode(
                indicator: RotatedBox(
                  quarterTurns: -1,
                  child: Text(date.toString()),
                ),
                startConnector: DashedLineConnector(
                  // gapColor: Colors.amber,
                  color: Colors.blue.shade200, dash: 1,
                ),
                endConnector: SolidLineConnector(),
              ),
            ),
            SizedBox(
              height: 356,
              width: MediaQuery.of(context).size.width - 46,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Divider(
                    //   thickness: 1,
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   // color: Color.fromARGB(255, 179, 217, 235),
                    //   child: Center(
                    //     child: Text(
                    //       date.toString(),
                    //       style: textTheme.bodyLarge
                    //           ?.copyWith(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 2,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Item: $name",
                            style: textTheme.bodyText2,
                          ),
                          Text(
                            "Amount: ${amount == null ? 0 : amount}",
                            style: textTheme.bodyText2,
                          ),
                          // SizedBox(
                          //   height: 2,
                          // ),
                          Text(
                            "Quantity: ${quantity == null ? 0 : quantity}",
                            style: textTheme.bodyText2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Details: ",
                                style: textTheme.bodyText2,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blue.shade100)),
                                child: Center(
                                  child: Text(
                                    "$details",
                                    textAlign: TextAlign.justify,
                                    style: textTheme.bodyText2,
                                  ),
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 2,
                          // ),
                          Text(
                            "Image: ..",
                            style: textTheme.bodyText2,
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
                                              ),
                                            )),
                              ),
                            ),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // )
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }
}
