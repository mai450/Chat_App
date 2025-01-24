import 'package:chat_app/constants/const.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.onChange,
      this.obscureText = false,
      this.suffixIcon});

  final String hintText;
  final IconData icon;
  final bool? obscureText;
  final Function(String)? onChange;
  final Widget? suffixIcon;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      obscureText: widget.obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This felid is required';
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: kPrimaryColor),
        prefixIcon: Icon(
          widget.icon,
          size: 18,
          color: kPrimaryColor,
        ),
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: const Color.fromARGB(255, 236, 236, 236),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 220, 220, 220),
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
