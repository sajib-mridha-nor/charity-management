import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class CustomRadioGroup extends StatefulWidget {
  final String label;
  final bool? require;
  final List<String> items;
  final String initialValue;
  final TextStyle? labelStyle;
  final TextStyle? itemTextStyle;
  final MainAxisAlignment mainAxisAlignment;
  final Axis direction;
  final Function(int index, String value) onChange;

  const CustomRadioGroup(
      {Key? key,
      required this.onChange,
      this.require,
      required this.label,
      this.direction = Axis.horizontal,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      required this.items,
      required this.initialValue,
      this.labelStyle,
      this.itemTextStyle})
      : super(key: key);

  @override
  State<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String? _value;

  @override
  void initState() {
    setState(() {
      _value = widget.initialValue;
    });
    _notifier(widget.initialValue);
    super.initState();
  }

  _notifier(value) {
    final index = widget.items.indexWhere((element) => element == value);
    widget.onChange(index, value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 600,
      // height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label +
                (widget.require == null || widget.require == true ? "" : ""),
            style: widget.labelStyle,
          ),
          const SizedBox(
            width: 4,
          ),
          RadioGroup<String>.builder(
            direction: widget.direction,
            groupValue: _value!,
            horizontalAlignment: widget.mainAxisAlignment,
            onChanged: (value) => setState(() {
              _value = value!;
              _notifier(value);
            }),
            items: widget.items,
            textStyle: widget.itemTextStyle,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
          )
        ],
      ),
    );
  }
}
