import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard(
      {Key? key,
      this.name,
      this.image,
      required this.onClick,
      required this.onDonate,
      this.nid,
      this.phone,
      this.union})
      : super(key: key);
  final String? name;
  final String? nid;
  final String? phone;
  final String? image;
  final String? union;
  final VoidCallback onClick;
  final VoidCallback onDonate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: image == null
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        AssetImage("assets/pngwing.com.png"))
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        "https://smartdonation.xyz/" +
                                            image.toString()))),
                      ),
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
                            Text(name ?? "Abul Fazal Mia",
                                style: textTheme.titleMedium
                                    ?.copyWith(color: Colors.black)),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text("NID: ",
                                    style: textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                                SizedBox(
                                  width: 18,
                                ),
                                Text(" ${(nid ?? "1234567890")}",
                                    style: textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text("Phone:",
                                    style: textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("${phone ?? "017xxxxxxx"}",
                                    style: textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text("Union: ",
                                    style: textTheme.bodyMedium?.copyWith()),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("${union ?? "Firuzpur"}",
                                    style: textTheme.bodyMedium?.copyWith()),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                                // height: 20,
                                // width: 80,
                                child: ElevatedButton(
                                    onPressed: onDonate, child: Text("Donate")))
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
                ],
              ),
            )),
      ),
    );
  }
}
