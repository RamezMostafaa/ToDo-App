import 'package:flutter/material.dart';
import 'package:todo_list/widget/my_them.dart';

class CustomTextFormField extends StatefulWidget {
  String? title;
  TextInputType? keyboardType;

  // void Function(String)? onChanged;
  // bool showEmailSuffixIcon;
  // FocusNode focusNode;

  TextEditingController? controller;

  String? Function(String?)? validator;
  bool obscureText;

  CustomTextFormField({
    required this.title,
    // required this.onChanged,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    // super.key,
    // this.showEmailSuffixIcon = true,
    // required this.focusNode,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        // style: TextStyle(
        //  color: MyTheme.blackLightColor
        // ),
        decoration: InputDecoration(
          // suffixIcon: widget.keyboardType == TextInputType.emailAddress
          //     ? Icon(Icons.check_circle,
          //     color: widget.showEmailSuffixIcon
          //         ? MyTheme.primaryColor
          //         : MyTheme.whiteColor)
          //     : widget.keyboardType == TextInputType.number
          //     ? IconButton(
          //     onPressed: () {
          //       widget.obscureText = !widget.obscureText;
          //       setState(() {});
          //     },
          //     icon: Icon(widget.obscureText
          //         ? Icons.visibility_off
          //         : Icons.visibility),
          //     color: MyTheme.primaryColor)
          //     : null,

          labelText: widget.title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: MyTheme.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: MyTheme.primaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: MyTheme.redColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: MyTheme.redColor),
          ),
          focusColor: MyTheme.primaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: MyTheme.primaryColor),
          ),
        ),
        maxLines: 1,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText,
        // onChanged: widget.onChanged,
        // focusNode: widget.focusNode,
      ),
    );
  }
}
