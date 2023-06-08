
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/pages/model/donate_get_response.dart';

import 'package:donation_tracker/utils/hexcolor.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';



class DonationPreviewPage extends StatelessWidget {
  

 

  
  DonationPreviewPage(
      {super.key, this.donation
     });
 List <Donation>? donation=[];

  @override
  Widget build(BuildContext context) {
   final state= donation;
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
            "Donation",   style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)
          ),
          centerTitle: true,
          // backgroundColor: Colors.blue.withOpacity(.5),
        ),
        body: 
       SingleChildScrollView(
         child: Column(children: [
               Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(state!.length, (index) {
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
                          }),)
              // DonationCard(amount: item?.amount,image: item?.image,date: donation?.donationDate,details:donation?.description,quantity: donation?.quantity,)
               ]),
       ));
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
                                      "Item",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ), Text(
                                      "Date",
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
                                      "$name",
                                      style: textTheme.bodyText2
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ), Text(
                                      "$date",
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
                                                "assets/noimage.png",
                                                height: 100,
                                              ))
                                      : List.generate(
                                          image!.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  "https://smartdonation.xyz/" +
                                                      image![index].toString(),
                                                  // height: 250,
                                                  // width: 200,
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
