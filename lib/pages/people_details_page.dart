import 'dart:ffi';

import 'package:donation_tracker/pages/details_page_controller.dart';
import 'package:donation_tracker/pages/donation_form_page.dart';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:donation_tracker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:grouped_list/grouped_list.dart';

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
        backgroundColor: Colors.white,
        // backgroundColor: Color.fromARGB(219, 201, 224, 244),
        appBar: AppBar(
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
                                    backgroundImage: NetworkImage(
                                        "https://ezze.dev/donation/" +
                                            image.toString())))),
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
                              style: textTheme.titleSmall
                                  ?.copyWith(color: Colors.black)),
                          Text("Gender:  ${gender ?? ""}",
                              style: textTheme.titleSmall
                                  ?.copyWith(color: Colors.black)),
                          Text("NID:  ${nid ?? ""}",
                              style: textTheme.titleSmall
                                  ?.copyWith(color: Colors.black)),
                          Text("Phone:  ${phone ?? ""}",
                              style: textTheme.titleSmall
                                  ?.copyWith(color: Colors.black)),
                          Text("Union:  ${union ?? ""}",
                              style: textTheme.titleSmall
                                  ?.copyWith(color: Colors.black)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 26,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: ThemeData.light().focusColor,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Total donation:${state?.length}",
                            style: textTheme.bodyText1
                                ?.copyWith(color: Colors.blue)),
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
              Divider(
                height: 2,
                thickness: 1,
              ),
              SizedBox(
                height: 0,
              ),
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 179, 217, 235),
            child: Center(
              child: Text(
                date.toString(),
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: $name",
                  style: textTheme.bodyLarge,
                ),
                Text(
                  "Amount: ${amount == null ? 0 : amount}",
                  style: textTheme.bodyLarge,
                ),
                // SizedBox(
                //   height: 2,
                // ),
                Text(
                  "Quantity: ${quantity == null ? 0 : quantity}",
                  style: textTheme.bodyLarge,
                ),
                Text(
                  "Details: $details",
                  style: textTheme.bodyLarge,
                ),
                // SizedBox(
                //   height: 2,
                // ),
                Text(
                  "Image: ..",
                  style: textTheme.bodyLarge,
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      "https://ezze.dev/donation/" +
                                          image![index].toString(),
                                    ),
                                  )),
                    ),
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
