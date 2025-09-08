import 'package:chat_app/constants/const.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.onChange,
      this.obscureText = false,
      this.suffixIcon,
      this.keyboardType,
      required this.controller});

  final String hintText;
  final IconData icon;
  final bool? obscureText;
  final Function(String)? onChange;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChange,
      obscureText: widget.obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This felid is required';
        }
      },
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          widget.icon,
          size: 18,
          color: kPrimaryColor,
        ),
        suffixIcon: widget.suffixIcon,
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(25),
    );
  }
}
