// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class TotalDonateHistory extends StatelessWidget {
//     TotalDonateHistory({super.key});
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context)
//         .textTheme
//         .apply(displayColor: Theme.of(context).colorScheme.onSurface);

//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.only(right: 8, left: 8, top: 8),
//         child: PagedListView<int, Contact>(
//           pagingController: controller.pagingController,
//           builderDelegate: PagedChildBuilderDelegate<Contact>(
//               itemBuilder: (context, item, index) => PeopleCard(
//                     name: item.name.toString(),
//                     nid: item.nidBirth.toString(),
//                     phone: item.mobile.toString(),
//                     union: item.union.toString(),
//                     onClick: () {
//                       print(item.id);
//                       Get.to(
//                           () => PeopleDetailsPage(
//                                 gender: item.gender,
//                                 name: item.name,
//                                 phone: item.mobile,
//                                 nid: item.nidBirth,
//                                 image: item.image,
//                                 union: item.union,
//                               ),
//                           arguments: {"d_id": item.id});
//                     },
//                     onDonate: () {
//                       Get.to(
//                           () => DonationFormPage(
//                                 name: item.name,
//                               ),
//                           arguments: {"c_id": item.id});
//                     },
//                   )),
//           // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           //     crossAxisCount: 2,
//           //     crossAxisSpacing: 8.0,
//           //     mainAxisSpacing: 0,
//           //     mainAxisExtent: 150),
//         ),
//       ),
//     );
//   }
// }
