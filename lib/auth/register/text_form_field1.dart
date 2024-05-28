import 'package:flutter/material.dart';

import '../../widget/my_them.dart';

class CustomTextFormField1 extends StatefulWidget {
  String? Function(String?)? validator;
  bool showEmailSuffixIcon;
  FocusNode? focusNode;
  bool obscureText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String label;
  TextInputType? keyboardType;
  bool? enableTheme;

  CustomTextFormField1({
    this.validator,
    required this.onChanged,
    required this.label,
    this.controller,
    this.focusNode,
    this.obscureText = true,
    this.keyboardType,
    this.showEmailSuffixIcon = true,
    super.key,
    this.enableTheme,
  });

  @override
  State<CustomTextFormField1> createState() => _CustomTextFormField1State();
}

class _CustomTextFormField1State extends State<CustomTextFormField1> {
  @override
  Widget build(BuildContext context) {
    // AppLocalizations appLocalization = AppLocalizations.of(context)!;

    return TextFormField(
        validator: widget.validator,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.redColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.redColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor, width: 2),
            ),
            suffixIcon: widget.keyboardType == TextInputType.emailAddress
                ? Icon(Icons.check_circle,
                    color: widget.showEmailSuffixIcon
                        ? MyTheme.primaryColor
                        : MyTheme.whiteColor)
                : widget.keyboardType == TextInputType.number
                    ? IconButton(
                        onPressed: () {
                          widget.obscureText = !widget.obscureText;
                          setState(() {});
                        },
                        icon: Icon(widget.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: MyTheme.primaryColor)
                    : null,
            label: Text(widget.label),

            // appLocalization.e_mail
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.primaryColor, width: 2),
            ),
            hintStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: MyTheme.whiteColor, fontSize: 20)),
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        maxLines: 1,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.black));
  }
}
