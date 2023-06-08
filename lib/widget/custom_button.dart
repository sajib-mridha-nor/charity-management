import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:flutter/material.dart';

import '../utils/palette.dart';

class CustomButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onClick;
  final String title;
  final EdgeInsets? padding;
  final Color? color;
  final double? radius;
  final double? fontSize;
  final bool islog;
  final Color? txtClr;
  const CustomButton(
      {Key? key,
      this.loading = false,
      required this.onClick,
      this.padding,
      this.radius,
      this.txtClr,
      this.islog = false,
      this.fontSize,
      this.color,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        // primary: Colors.transparent,
        // backgroundColor: loading ? Colors.white60:Colors.blue,
        shadowColor: HexColor("#2F5F8A"),
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 6.0),
        ),
      ),
      onPressed: loading == true ? null : onClick,
      child: Ink(
        decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [
          //   color ?? Colors.blue.shade400,
          //   color ?? Colors.blue.shade200,
          // ]),
          borderRadius: BorderRadius.circular(radius ?? 6.0),
        ),
        child: Container(
          width: double.infinity,
          padding: padding ?? EdgeInsets.all(12),
          constraints: const BoxConstraints(minWidth: 88.0),
          child: loading == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        textAlign: TextAlign.center,
                        style: textTheme.button?.copyWith(
                            fontSize: fontSize ?? 20,
                            color: txtClr,fontWeight: FontWeight.bold
                           )
                        //  TextStyle(
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.white,
                        //     fontSize: 16),
                        ),
                    // islog
                    //     ? Padding(
                    //         padding: const EdgeInsets.only(left: 8, top: 4),
                    //         child: Icon(
                    //           Icons.login,
                    //           color: txtClr,
                    //           size: 24,
                    //         ),
                    //       )
                    //     : Container()
                  ],
                )
              : const Center(
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )),
                ),
        ),
      ),
    );
  }
}
