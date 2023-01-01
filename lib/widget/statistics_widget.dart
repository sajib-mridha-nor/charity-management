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
    return Totals(
        height: height,
        width: width,
        icon: icon,
        title: title,
        caption: caption);
  }
}

class Totals extends StatelessWidget {
  const Totals({
    Key? key,
    required this.height,
    required this.width,
    required this.icon,
    this.offeset,
    required this.title,
    required this.caption,
  }) : super(key: key);

  final double? height;
  final double? width;
  final String icon;
  final String title;
  final Offset? offeset;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      width: width ?? 300,
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.5),
            spreadRadius: offeset == null ? 1 : 0,
            blurRadius: offeset == null ? 1 : 0,
            offset: offeset ?? Offset(2, 3), // changes position of shadow
          )
        ],
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
          SizedBox(
            height: 4,
          ),
          Image.asset(
            icon,
            height: 36,
            width: 36,
            fit: BoxFit.cover,
          ),
          // CircleAvatar(
          //   backgroundColor: Colors.transparent,
          //   radius: 20,
          //   backgroundImage: AssetImage(icon),
          // ),
          // Image.asset("assets/donation.png", height: 45, width: 45),
          // ,
          SizedBox(
            height: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Center(
                child: Text(
                  caption,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
