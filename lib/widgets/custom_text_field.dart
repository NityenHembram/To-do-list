import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.labelText,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.onChanged,
      this.maxLines = 1,
      this.focusNode,
      this.readOnly = false});

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final int maxLines;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(labelText ?? '')),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: maxLines,
      focusNode: focusNode,
      readOnly: readOnly,
      
    );
  }
}
