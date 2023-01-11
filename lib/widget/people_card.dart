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
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
          elevation: 1,
          color: HexColor("#E8EFF2"),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
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
                                  "https://ezze.dev/donation/" +
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
                          style: textTheme.titleSmall
                              ?.copyWith(color: Colors.black)),
                      Text("NID:  ${(nid ?? "1234567890")}",
                          style: textTheme.titleSmall
                              ?.copyWith(color: Colors.black)),
                      Text("Phone:  ${phone ?? "017xxxxxxx"}",
                          style: textTheme.titleSmall
                              ?.copyWith(color: Colors.black)),
                      Text("Union:  ${union ?? "Firuzpur"}",
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
                Expanded(
                  flex: 4,
                  child: SizedBox(
                      // height: 20,
                      // width: 80,
                      child: ElevatedButton(
                          onPressed: onDonate, child: Text("Donate"))),
                )
              ],
            ),
          )),
    );
  }
}
