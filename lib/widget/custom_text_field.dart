import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/hexcolor.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final String? error;
  final String? initialValue;
  final TextStyle? labelStyle;
  final bool? require;
  final Function onChange;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isPasswordField;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final int? minLength;
  final bool readOnly;
  final String? helperTxt;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField(
      {Key? key,
      this.label,
      this.labelStyle,
      this.require,
      required this.hint,
      this.helperTxt,
      this.error,
      required this.onChange,
      this.initialValue,
      this.keyboardType,
      this.maxLines = 1,
      this.isPasswordField = false,
      this.maxLength,
      this.textStyle,
      this.textInputAction,
      this.minLength,
      this.readOnly = false,
      this.inputFormatters})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordInVisible = true;
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    if (widget.initialValue != null) {
      widget.onChange(widget.initialValue!);
    }
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.label == ''
            ? Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.label,
                      style: widget.labelStyle ??
                          DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        widget.require == null || widget.require == true
                            ? const TextSpan(
                                text: ' *', style: TextStyle(color: Colors.red))
                            : const TextSpan(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              )
            : Container(),
        TextFormField(
          onTap: () {
            setState(() {
              FocusScope.of(context).requestFocus(myFocusNode);
            });
          },
          focusNode: myFocusNode,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          style: widget.textStyle,
          readOnly: widget.readOnly,
          initialValue: widget.initialValue,
          inputFormatters: widget.keyboardType == TextInputType.number
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ]
              : null,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          obscureText:
              widget.isPasswordField == true ? _passwordInVisible : false,
          decoration: InputDecoration(
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      icon: Icon(
                          _passwordInVisible
                              ? Icons.visibility_off
                              : Icons.visibility,size: 22,
                          color: HexColor("#C4C4C4")),
                      onPressed: () {
                        setState(() {
                          _passwordInVisible =
                              !_passwordInVisible; //change boolean value
                        });
                      },
                    )
                  : null,
              hintText: widget.hint,
              label: Text(
                "${widget.helperTxt}",
                // style: textTheme.titleMedium,
              ),
              labelStyle: textTheme.caption?.copyWith(
                  fontSize: 16,
                  color: myFocusNode.hasFocus
                      ? HexColor("#3d8ede").withOpacity(.6)
                      : Colors.black54),
              counterText: "",
              // helperText: widget.helperTxt,
              hintStyle: textTheme.bodySmall?.copyWith(
                fontSize: 16,
              ),
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
                    width: 2, color: HexColor("#3d8ede").withOpacity(.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: HexColor("#3d8ede").withOpacity(.8),
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: HexColor("#C4C4C4"),
                  width: 2,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
          onChanged: (value) {
            widget.onChange(value);
          },
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
            if (widget.minLength != null) {
              if (value.length < widget.minLength!) {
                if (widget.error == null) {
                  return widget.hint;
                }
                return widget.error;
              }
            }
            return null;
          },
        )
      ],
    );
  }
}
