import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:flutter/material.dart';

class StatisticWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String caption;
  final double? height;
  final double? width;

  const StatisticWidget(
      {Key? key,
      required this.icon,
      required this.title,
      this.height,
      this.width,
      required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      width: width ?? 300,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: RadialGradient(stops: [
          .2,
          .9
        ], colors: [
          Color.fromARGB(255, 115, 183, 239),
          Colors.white,
        ]),
        color: HexColor("#E8EFF2").withOpacity(.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            backgroundImage: AssetImage(icon),
          ),
          // Image.asset("assets/donation.png", height: 45, width: 45),
          // ,
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                caption,
                style: TextStyle(fontSize: 11, overflow: TextOverflow.fade),
              ),
            ],
          )
        ],
      ),
    );
  }
}
