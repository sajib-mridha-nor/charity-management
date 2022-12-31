import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CustomDatePicker extends StatelessWidget {
  final Function(String? v) onChange;
  final String label;
  final String hint;
  final String? error;
  final TextStyle? labelStyle;
  final bool require;
  final String? initialValue;
  final String dateMask;

  const CustomDatePicker(
      {Key? key,
      required this.label,
      required this.hint,
      this.require = true,
      this.initialValue,
      required this.onChange,
      this.labelStyle,
      this.error,
      this.dateMask = 'd MMMM, yyyy'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    initializeDateFormatting();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   label + (require == true ? " *" : ""),
        //   style: labelStyle,
        // ),
        // const SizedBox(
        //   height: 4,
        // ),
        DateTimePicker(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.calendar_today,
                size: 24,
                color: HexColor("#C4C4C4"),
              ),
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: HexColor("#3d8ede").withOpacity(.3),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: HexColor("#3d8ede").withOpacity(.3),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  width: 2,
                  color: HexColor("#3d8ede").withOpacity(.5),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              hintText: hint,
              helperStyle: textTheme.caption?.copyWith(fontSize: 16)),
          type: DateTimePickerType.date,
          dateMask: dateMask,
          initialValue: initialValue,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          use24HourFormat: false,
          locale: const Locale('en', 'US'),
          validator: (value) {
            if (require == false) {
              return null;
            }
            if (value == null || value.isEmpty) {
              if (error == null) {
                return hint;
              }
              return error;
            }
            return null;
          },
          onChanged: onChange,
        )
      ],
    );
  }
}
