import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String? label;
  final String hint;
  final String? error;
  final String? initialValue;
  final TextStyle? labelStyle;
  final List<String> items;
  final bool? require;
  final Function(String? value) onChange;

  const CustomDropdown(
      {Key? key,
      this.label,
      this.labelStyle,
      required this.items,
      this.require,
      required this.hint,
      this.error,
      required this.onChange,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // widget.label != ""
        //     ? Column(
        //         children: [
        //           RichText(
        //             text: TextSpan(
        //               text: widget.label,
        //               style: widget.labelStyle ??
        //                   DefaultTextStyle.of(context).style,
        //               children: <TextSpan>[
        //                 widget.require == null || widget.require == true
        //                     ? const TextSpan(
        //                         text: ' ', style: TextStyle(color: Colors.red))
        //                     : const TextSpan(),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 4,
        //           ),
        //         ],
        //       )
        //     : Container(),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                validator: (value) {
                  if (widget.require == false) {
                    return null;
                  }
                  if (value == null || value.isEmpty) {
                    if (widget.error == null) {
                      return widget.hint;
                    }
                    return widget.error;
                  }
                  return null;
                },
                value: widget.items.any((element) =>
                        element == _currentSelectedValue.toString().trim() ||
                        element == widget.initialValue)
                    ? (_currentSelectedValue ?? widget.initialValue)
                    : null,
                decoration: InputDecoration(
                    labelText: widget.hint,
                    labelStyle: TextStyle(color: Colors.blue.withOpacity(.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: HexColor("#3d8ede").withOpacity(.5),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16)),
                hint: Text(widget.hint,
                    style: textTheme.caption?.copyWith(fontSize: 16)),
                isDense: true,
                onChanged: (newValue) {
                  widget.onChange(newValue);
                  setState(() {
                    _currentSelectedValue = newValue!;
                    state.didChange(newValue);
                  });
                },
                items: widget.items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
              ),
            );
          },
        )
      ],
    );
  }
}
